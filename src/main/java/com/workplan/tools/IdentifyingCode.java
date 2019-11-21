package com.workplan.tools;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

/**
 * 登陆用验证码
 * 生成的验证码保存在session中，名称为：VALIDATE_CODE
 * @author 01059101
 *
 */
@Controller
public class IdentifyingCode {
	private int width = 116;
	private int height = 36;
	private int codeCount = 5;
	private int x = 0;
	private int fontHeight;
	private int codeY;
	char[] codeSequence = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K',
			'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y',
			'Z', '2', '3', '4', '5', '6', '7', '8', '9' };

	@RequestMapping("/IdentifyingCode")
	public void getCode(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
	    this.x = (this.width / (this.codeCount + 1));
	    this.fontHeight = (this.height - 2);
	    this.codeY = (this.height - 4);
		BufferedImage buffImg = new BufferedImage(this.width, this.height, 1);
		Graphics2D g = buffImg.createGraphics();
		Random random = new Random();
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, this.width, this.height);

		Font font = new Font("Fixedsys", 1, this.fontHeight);
		g.setFont(font);
		g.setColor(Color.BLACK);
		g.drawRect(0, 0, this.width - 1, this.height - 1);
		g.setColor(Color.pink);
		for (int i = 0; i < 60; ++i) {
			int x = random.nextInt(this.width);
			int y = random.nextInt(this.height);
			int xl = random.nextInt(12);
			int yl = random.nextInt(12);
			g.drawLine(x, y, x + xl, y + yl);
		}

		StringBuffer randomCode = new StringBuffer();
		int red = 0;
		int green = 0;
		int blue = 0;

		for (int i = 0; i < this.codeCount; ++i) {
			String strRand = String.valueOf(this.codeSequence[random
					.nextInt(32)]);
			red = random.nextInt(155);
			green = random.nextInt(100);
			blue = random.nextInt(255);
			g.setColor(new Color(red, green, blue));
			g.drawString(strRand, (i + 1) * this.x - 6, this.codeY);
			randomCode.append(strRand);
		}
		HttpSession session = req.getSession();
		session.setAttribute("VALIDATE_CODE", randomCode.toString());
		String validateCodeInSession = (String) session.getAttribute("VALIDATE_CODE");
		System.out.println("生成的验证码为："+validateCodeInSession);
		resp.setHeader("Pragma", "no-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setDateHeader("Expires", 0L);
		resp.setContentType("image/jpeg");
		ServletOutputStream sos = resp.getOutputStream();
		ImageIO.write(buffImg, "jpeg", sos);
		sos.close();
	}

}