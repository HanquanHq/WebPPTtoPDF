package hanquan;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.poi.hslf.usermodel.HSLFShape;
import org.apache.poi.hslf.usermodel.HSLFSlide;
import org.apache.poi.hslf.usermodel.HSLFSlideShow;
import org.apache.poi.hslf.usermodel.HSLFTextParagraph;
import org.apache.poi.hslf.usermodel.HSLFTextRun;
import org.apache.poi.hslf.usermodel.HSLFTextShape;
import org.apache.poi.xslf.usermodel.XMLSlideShow;
import org.apache.poi.xslf.usermodel.XSLFShape;
import org.apache.poi.xslf.usermodel.XSLFSlide;
import org.apache.poi.xslf.usermodel.XSLFTextParagraph;
import org.apache.poi.xslf.usermodel.XSLFTextRun;
import org.apache.poi.xslf.usermodel.XSLFTextShape;

import java.io.FileOutputStream;
import java.io.IOException;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.pdf.PdfWriter;

public class PPTtoPDF {
	public static void main(String[] args) throws IOException {
		// ConvertPPTX("test.pptx");
//		ConvertPPT("a.ppt",1,2,0);
//		ConvertPPT("b.ppt",1,3,0);
//		ConvertPPT("3.ppt",1,2,1);
//		ConvertPPT("4.ppt",1,3,1);
//		ConvertPPT("c.ppt",2,4,0);
//		ConvertPPT("6.ppt",2,4,1);
//		ConvertPPT("d.ppt",2,5,0);
//		ConvertPPT("8.ppt",2,5,1);
//		ConvertPPT("e.ppt",3,7,0);
//		ConvertPPT("10.ppt",3,7,1);
//		ConvertPPT("f.ppt",3,8,0);
//		ConvertPPT("12.ppt",3,8,1);	
		// ConvertPPT("��1�� �������հ�-2019.ppt");
	}

	public static int QI_HENG;
	public static int QI_SHU;
	public static int TU_HENG;
	public static int TU_SHU;
	public static int SHU_JIAN;
	public static int HENG_ZENG;
	public static int HENG_QIUYU;
	public static int SHU_QIUYU = 790;
	public static String PATH = "C:/Users/Bug/eclipse-workspace3/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/WebPPTtoPDF/image/";

	// PPT2003��ʽ
	public static void ConvertPPT(String fileName, int m, int n, int scale) throws IOException {
		System.out.println("m=" + m);
		System.out.println("n=" + n);
		// ��������Ŀ¼
		String str = PATH + fileName.substring(0, fileName.length() - 4);// ע������-4
		File filePath = new File(str);
		if (!filePath.exists()) {
			filePath.mkdirs();
		}
		System.out.println("strPath=" + str);

		File file = new File(PATH + fileName);
		File imageFile = new File(PATH);

		// ����ppt��ҳ��
		HSLFSlideShow ppt = new HSLFSlideShow(new FileInputStream(file));
		Dimension pgSize = ppt.getPageSize();
		List<HSLFSlide> slideList = ppt.getSlides();
		int pageNum = slideList.size();
		System.out.println("ppt��ҳ��Ϊ��" + pageNum);

		// ����png
		System.out.println("(0)");
		List<String> pathList = doPPT2003ToImage(new FileInputStream(file), imageFile, fileName);
		System.out.println("(1)");
		for (String s : pathList) {
			System.out.println(s);
		}

		// ����pdf
		fillTemplate(imageFile, fileName, pageNum, m, n, scale);
	}

	// PPTX2007��ʽ
	public static void ConvertPPTX(String fileName, int m, int n, int scale) throws IOException {
		// ��������Ŀ¼
		System.out.println("m=" + m);
		System.out.println("n=" + n);

		String str = PATH + fileName.substring(0, fileName.length() - 5);

		File filePath = new File(str);
		if (!filePath.exists()) {
			filePath.mkdirs();
		}
		System.out.println("strPath=" + str);

		File file = new File(PATH + fileName);
		File imageFile = new File(PATH);

		// ����pptx��ҳ��
		XMLSlideShow ppt = new XMLSlideShow(new FileInputStream(file));
		Dimension pgSize = ppt.getPageSize();
		List<XSLFSlide> slideList = ppt.getSlides();
		int pageNum = slideList.size();
		System.out.println("pptx��ҳ��Ϊ��" + pageNum);

		// ����png
		System.out.println("(0)");
		List<String> pathList = doPPT2007ToImage(new FileInputStream(file), imageFile, fileName);

		for (String s : pathList) {
			System.out.println(s);
		}

		// ����pdf
		fillTemplate(imageFile, fileName, pageNum, m, n, scale);
	}

	// ����pdf
	public static void fillTemplate(File imageFile, String fileName, int pageNum, int m, int n, int scale) {
		// �������ȡ�ļ���
		String shortFileName;
		if (fileName.endsWith("pptx")) {
			shortFileName = fileName.substring(0, fileName.length() - 5);// ȥ����׺���ļ���
		} else {
			shortFileName = fileName.substring(0, fileName.length() - 4);// ȥ����׺���ļ���
		}

		try {
			// Step 1��Create a Document.
			Document document = new Document();
			// Step 2��Get a PdfWriter instance.
			PdfWriter.getInstance(document, new FileOutputStream(PATH + shortFileName + "/" + shortFileName + ".pdf"));
			// Step 3��Open the Document.
			document.open();

			// �ж�һ��Ӧ���ɼ�ҳpdf
			int k0 = m * n;// һҳpdf���м���ppt
			int pdfNum;
			if (pageNum % k0 == 0)
				pdfNum = pageNum / k0;
			else
				pdfNum = pageNum / k0 + 1;
			System.out.println("һ����" + pdfNum + "ҳpdf");

			if (scale == 0) {
				// ppt����Ϊ4:3�������߼�ֵ '0' ��ʾ
				if (m == 1) {
					switch (n) {
					case 2: {
						QI_HENG = 50;
						QI_SHU = 430;
						TU_HENG = 495;
						TU_SHU = 370;
						SHU_JIAN = 380;
						HENG_ZENG = 540;
						HENG_QIUYU = 540;
						break;
					}
					case 3: {
						QI_HENG = 125;
						QI_SHU = 557;
						TU_HENG = 540;
						TU_SHU = 263;
						SHU_JIAN = 263;
						HENG_ZENG = 532;
						HENG_QIUYU = 532;
						break;
					}
					}
				} else if (m == 2) {
					switch (n) {
					case 4: {
						QI_HENG = 25;
						QI_SHU = 622;
						TU_HENG = 270;
						TU_SHU = 197;
						SHU_JIAN = 197;
						HENG_ZENG = 275;
						HENG_QIUYU = 550;
						break;
					}
					case 5: {
						QI_HENG = 50;
						QI_SHU = 662;
						TU_HENG = 270;
						TU_SHU = 158;
						SHU_JIAN = 162;
						HENG_ZENG = 275;
						HENG_QIUYU = 550;
						break;
					}
					}
				} else {
					switch (n) {
					case 7: {
						QI_HENG = 40;
						QI_SHU = 712;
						TU_HENG = 180;
						TU_SHU = 112;
						SHU_JIAN = 115;
						HENG_ZENG = 183;
						HENG_QIUYU = 549;
						break;
					}
					case 8: {
						QI_HENG = 50;
						QI_SHU = 720;
						TU_HENG = 170;
						TU_SHU = 95;
						SHU_JIAN = 98;
						HENG_ZENG = 180;
						HENG_QIUYU = 540;
						break;
					}
					}
				}
			} else {
				// ppt����Ϊ16:9 �������߼�ֵ '1'��ʾ
				if (m == 1) {
					switch (n) {
					case 2: {
						QI_HENG = 50;
						QI_SHU = 450;
						TU_HENG = 495;
						TU_SHU = 370;
						SHU_JIAN = 360;
						HENG_ZENG = 540;
						HENG_QIUYU = 540;
						break;
					}
					case 3: {
						QI_HENG = 65;
						QI_SHU = 557;
						TU_HENG = 540;
						TU_SHU = 263;
						SHU_JIAN = 268;
						HENG_ZENG = 532;
						HENG_QIUYU = 532;
						break;
					}
					}
				} else if (m == 2) {
					switch (n) {
					case 4: {
						QI_HENG = 25;
						QI_SHU = 642;
						TU_HENG = 270;
						TU_SHU = 197;
						SHU_JIAN = 197;
						HENG_ZENG = 275;
						HENG_QIUYU = 550;
						break;
					}
					case 5: {
						QI_HENG = 25;
						QI_SHU = 662;
						TU_HENG = 270;
						TU_SHU = 158;
						SHU_JIAN = 158;
						HENG_ZENG = 275;
						HENG_QIUYU = 550;
						break;
					}
					}
				} else {
					switch (n) {
					case 7: {
						QI_HENG = 25;
						QI_SHU = 712;
						TU_HENG = 180;
						TU_SHU = 112;
						SHU_JIAN = 115;
						HENG_ZENG = 183;
						HENG_QIUYU = 549;
						break;
					}
					case 8: {
						QI_HENG = 33;
						QI_SHU = 720;
						TU_HENG = 170;
						TU_SHU = 95;
						SHU_JIAN = 98;
						HENG_ZENG = 180;
						HENG_QIUYU = 540;
						break;
					}
					}
				}
			}

//��ʼ����pdf��ÿһҳ			
			// Step 4��Add content.
			int i = 0;// i��¼��ǰ�ǵڼ�ҳpdf
			Image[] image = new Image[pageNum];
			// ǰ���ÿһҳ
			for (i = 0; i < pdfNum - 1; i++) // ǰ��ģ��������һҳpdf
			{
				System.out.println("���ǵ�" + (i + 1) + "ҳpdf");
				document.newPage();
				System.out.println("QI_HENG=" + QI_HENG + "QI_SHU" + QI_SHU);
				int heng = QI_HENG, shu = QI_SHU;
				int p = 1;
				for (int k = m * n * i; k < m * n * (i + 1); k++) {
					System.out.println("k=" + k);
					System.out.println("heng=" + heng + "shu=" + shu);
					// ��ͼƬ
					image[k] = Image.getInstance(imageFile.getAbsolutePath() + "/" + shortFileName + "/" + shortFileName
							+ "pic" + k + ".png");
					image[k].scaleToFit(TU_HENG, TU_SHU);
					// image[k].setAbsolutePosition(-700+k*20, -700+juli*200);
					image[k].setAbsolutePosition(heng, shu);
					// ���ͼƬ
					document.add(image[k]);
					heng += HENG_ZENG;
					System.out.println("HENG_QIUYU=" + HENG_QIUYU);
					heng %= HENG_QIUYU;

					if (p % m == 0)
						shu -= SHU_JIAN;
					p++;
					shu %= SHU_QIUYU;
				}
			}

			// ���һҳpdf
			document.newPage();
			int heng = QI_HENG, shu = QI_SHU;
			int p = 1;
			for (int k = m * n * i; k < pageNum; k++) {
				System.out.println("k=" + k);
				// System.out.println("heng=" + heng + "shu=" + shu);
				System.out.println("���ǵ�" + (i + 1) + "ҳpdf");
				// ��ͼƬ
				image[k] = Image.getInstance(
						imageFile.getAbsolutePath() + "/" + shortFileName + "/" + shortFileName + "pic" + k + ".png");
				image[k].scaleToFit(TU_HENG, TU_SHU);
				// image[k].setAbsolutePosition(-700+k*20, -700+juli*200);
				image[k].setAbsolutePosition(heng, shu);
				// ���ͼƬ
				document.add(image[k]);

				heng += HENG_ZENG;
				heng %= HENG_QIUYU;

				if (p % m == 0)
					shu -= SHU_JIAN;
				p++;

				shu %= SHU_QIUYU;
			}

			// Step 5��Close the Document.
			document.close();

		} catch (IOException e) {
			System.out.println("�����Ƿ��ļ��Ѿ���/ͼƬ�Ƿ����" + e);// �����Ƿ��ļ��Ѿ���
		} catch (DocumentException e) {
			System.out.println(e);
		}
	}

	// ����ͼƬ
	public static List<String> doPPT2007ToImage(File file, File imageFile) {// PPTx-->image

		List<String> pathList = new ArrayList<String>();
		try {
			FileInputStream inputStream = new FileInputStream(file);
			XMLSlideShow ppt = new XMLSlideShow(inputStream);
			Dimension pgSize = ppt.getPageSize();
			List<XSLFSlide> slideList = ppt.getSlides();

			for (int i = 0; i < slideList.size(); i++) {

				for (XSLFShape shape : ppt.getSlides().get(i).getShapes()) {
					if (shape instanceof XSLFTextShape) {
						XSLFTextShape tsh = (XSLFTextShape) shape;
						for (XSLFTextParagraph p : tsh) {
							for (XSLFTextRun r : p) {
								r.setFontFamily("����");
							}
						}
					}
				}

				BufferedImage image = new BufferedImage(pgSize.width, pgSize.height, BufferedImage.TYPE_INT_RGB);
				Graphics2D graphics = image.createGraphics();
				// ����
				graphics.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
				// ����ߵľ�ȷ�Ⱥ��Ӿ�����ִ����ɫת�����㡣
				graphics.setRenderingHint(RenderingHints.KEY_COLOR_RENDERING,
						RenderingHints.VALUE_COLOR_RENDER_QUALITY);
				// ����ƫ���ڴ����ٵݻ�������-ƫ��������
				graphics.setRenderingHint(RenderingHints.KEY_ALPHA_INTERPOLATION,
						RenderingHints.VALUE_ALPHA_INTERPOLATION_QUALITY);

				graphics.setPaint(Color.white);
				graphics.fill(new Rectangle(0, 0, pgSize.width, pgSize.height));
				slideList.get(i).draw(graphics);

				if (!imageFile.exists()) {
					imageFile.mkdirs();
				}
				pathList.add(imageFile.getAbsolutePath() + "\\pic" + i + ".png");
				FileOutputStream outputStream = new FileOutputStream(
						new File(imageFile.getAbsolutePath() + "\\pic" + i + ".png"));
				ImageIO.write(image, "png", outputStream);
				outputStream.close();
			}

			ppt.close();
			return pathList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static List<String> doPPT2007ToImage(FileInputStream inputStream, File imageFile, String fileName) {// PPTx-->image
		System.out.println("(doPPT2007ToImage)");
		List<String> pathList = new ArrayList<String>();
		try {
			XMLSlideShow ppt = new XMLSlideShow(inputStream);
			Dimension pgSize = ppt.getPageSize();
			List<XSLFSlide> slideList = ppt.getSlides();

			for (int i = 0; i < slideList.size(); i++) {

				for (XSLFShape shape : ppt.getSlides().get(i).getShapes()) {
					if (shape instanceof XSLFTextShape) {
						XSLFTextShape tsh = (XSLFTextShape) shape;
						for (XSLFTextParagraph p : tsh) {
							for (XSLFTextRun r : p) {
								r.setFontFamily("����");
							}
						}
					}
				}

				BufferedImage image = new BufferedImage(pgSize.width, pgSize.height, BufferedImage.TYPE_INT_RGB);
				Graphics2D graphics = image.createGraphics();

				// ����
				graphics.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
				// ����ߵľ�ȷ�Ⱥ��Ӿ�����ִ����ɫת�����㡣
				graphics.setRenderingHint(RenderingHints.KEY_COLOR_RENDERING,
						RenderingHints.VALUE_COLOR_RENDER_QUALITY);
				// ����ƫ���ڴ����ٵݻ�������-ƫ��������
				graphics.setRenderingHint(RenderingHints.KEY_ALPHA_INTERPOLATION,
						RenderingHints.VALUE_ALPHA_INTERPOLATION_QUALITY);

				graphics.setPaint(Color.white);
				graphics.fill(new Rectangle(0, 0, pgSize.width, pgSize.height));
				slideList.get(i).draw(graphics);

				if (!imageFile.exists()) {
					imageFile.mkdirs();
				}

				String shortFileName = fileName.substring(0, fileName.length() - 5);// ȥ����׺���ļ���

				pathList.add(
						imageFile.getAbsolutePath() + "\\" + shortFileName + "\\" + shortFileName + "pic" + i + ".png");

				FileOutputStream outputStream = new FileOutputStream(new File(imageFile.getAbsolutePath() + "\\"
						+ shortFileName + "\\" + shortFileName + "pic" + i + ".png"));

				ImageIO.write(image, "png", outputStream);
				outputStream.close();
			}
			ppt.close();
			return pathList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static List<String> doPPT2003ToImage(File file, File imageFile) {//// PPT-->image

		List<String> pathList = new ArrayList<String>();
		try {
			FileInputStream inputStream = new FileInputStream(file);

			HSLFSlideShow ppt = new HSLFSlideShow(inputStream);
			Dimension pgSize = ppt.getPageSize();
			List<HSLFSlide> slideList = ppt.getSlides();

			for (int i = 0; i < slideList.size(); i++) {

				for (HSLFShape shape : ppt.getSlides().get(i).getShapes()) {
					if (shape instanceof HSLFTextShape) {
						HSLFTextShape tsh = (HSLFTextShape) shape;
						for (HSLFTextParagraph p : tsh) {
							for (HSLFTextRun r : p) {
								r.setFontFamily("����");
							}
						}
					}
				}

				BufferedImage image = new BufferedImage(pgSize.width, pgSize.height, BufferedImage.TYPE_INT_RGB);
				Graphics2D graphics = image.createGraphics();

				// ����
				graphics.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
				// ����ߵľ�ȷ�Ⱥ��Ӿ�����ִ����ɫת�����㡣
				graphics.setRenderingHint(RenderingHints.KEY_COLOR_RENDERING,
						RenderingHints.VALUE_COLOR_RENDER_QUALITY);
				// ����ƫ���ڴ����ٵݻ�������-ƫ��������
				graphics.setRenderingHint(RenderingHints.KEY_ALPHA_INTERPOLATION,
						RenderingHints.VALUE_ALPHA_INTERPOLATION_QUALITY);

				graphics.setPaint(Color.white);
				graphics.fill(new Rectangle(0, 0, pgSize.width, pgSize.height));
				slideList.get(i).draw(graphics);

				if (!imageFile.exists()) {
					imageFile.mkdirs();
				}
				pathList.add(imageFile.getAbsolutePath() + "\\pic" + i + ".png");
				FileOutputStream outputStream = new FileOutputStream(
						new File(imageFile.getAbsolutePath() + "\\pic" + i + ".png"));
				ImageIO.write(image, "png", outputStream);
				outputStream.close();
			}
			ppt.close();
			return pathList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static List<String> doPPT2003ToImage(FileInputStream inputStream, File imageFile, String fileName) {// PPT-->image
		System.out.println("(doPPT2003ToImage)");
		List<String> pathList = new ArrayList<String>();
		try {
			HSLFSlideShow ppt = new HSLFSlideShow(inputStream);
			Dimension pgSize = ppt.getPageSize();
			List<HSLFSlide> slideList = ppt.getSlides();

			for (int i = 0; i < slideList.size(); i++) {
				for (HSLFShape shape : ppt.getSlides().get(i).getShapes()) {
					if (shape instanceof HSLFTextShape) {
						HSLFTextShape tsh = (HSLFTextShape) shape;
						for (HSLFTextParagraph p : tsh) {
							for (HSLFTextRun r : p) {
								r.setFontFamily("����");
							}
						}
					}
				}

				BufferedImage image = new BufferedImage(pgSize.width, pgSize.height, BufferedImage.TYPE_INT_RGB);
				Graphics2D graphics = image.createGraphics();

				// ����
				graphics.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
				// ����ߵľ�ȷ�Ⱥ��Ӿ�����ִ����ɫת�����㡣
				graphics.setRenderingHint(RenderingHints.KEY_COLOR_RENDERING,
						RenderingHints.VALUE_COLOR_RENDER_QUALITY);
				// ����ƫ���ڴ����ٵݻ�������-ƫ��������
				graphics.setRenderingHint(RenderingHints.KEY_ALPHA_INTERPOLATION,
						RenderingHints.VALUE_ALPHA_INTERPOLATION_QUALITY);
				graphics.setPaint(Color.white);
				graphics.fill(new Rectangle(0, 0, pgSize.width, pgSize.height));
				slideList.get(i).draw(graphics);

				String shortFileName = fileName.substring(0, fileName.length() - 4);// ȥ����׺���ļ���

				if (!imageFile.exists()) {
					imageFile.mkdirs();
				}

				pathList.add(
						imageFile.getAbsolutePath() + "\\" + shortFileName + "\\" + shortFileName + "pic" + i + ".png");

				FileOutputStream outputStream = new FileOutputStream(new File(imageFile.getAbsolutePath() + "\\"
						+ shortFileName + "\\" + shortFileName + "pic" + i + ".png"));

				ImageIO.write(image, "png", outputStream);
				outputStream.close();
			}
			ppt.close();
			return pathList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
