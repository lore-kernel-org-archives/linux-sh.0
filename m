From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 15 Nov 2012 15:28:58 +0000
Subject: I2C: kzm9g: how to suppress a stop condition?
Message-Id: <Pine.LNX.4.64.1211151609330.684@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Kobayashi-san

Recently you submitted a patch [1] to U-Boot to suppress a stop condition 
on I2C during ready after the transmission of the register address on 
sh73a0. The same problem is present under Linux, which prevents the AS3711 
PMIC from working correctly. Actually I'm not sure whether this problem is 
pecific to sh73a0, or it's the PMIC, that's so picky about the stop 
condition at that stage. I've been trying to fix this problem under Linux 
since several hours and so far I haven't been successful. The Linux driver 
is interrupt driven, so, it is not quite easy to compare register accesses 
1-to-1, but in principle they seem very similar. However, if I just remove 
setting the stop condition after the address, the driver times out and on 
the bus I see, that the sh73a0 sends the first byte correctly - the client 
address, but then it stops clocking the I2C bus, respectively, no ack from 
the client is coming and the whole thing breaks down. Do you have an idea 
how to fix that too?

Thanks
Guennadi

[1] http://article.gmane.org/gmane.comp.boot-loaders.u-boot/140553
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
