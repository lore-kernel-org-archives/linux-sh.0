From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 07 May 2012 16:43:23 +0000
Subject: [Q] (intentionally) useless code in pinmux_config_gpio()
Message-Id: <Pine.LNX.4.64.1205071836120.3564@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi

Looking at pinmux_config_gpio() in drivers/sh/pfc.c I came across code, 
that doesn't seem to have any effect:

	while (1) {
		...
		switch (cfg_mode) {
		case GPIO_CFG_DRYRUN:
			if (condition)
				continue;
			break;
		...
		}
	}

So, whether the condition in "if" above is true or false the loop just 
continues. Evaluation of the condition doesn't have any effect either. Is 
this really how it was intended?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
