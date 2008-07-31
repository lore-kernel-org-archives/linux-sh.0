From: Luca Santini <luca.santini@spesonline.com>
Date: Thu, 31 Jul 2008 14:26:25 +0000
Subject: i2c old to new style conversion
Message-Id: <4891CB91.6040308@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Manuel,
i'm trying the conversion of wm8731 driver and a attach my patch.

The problem is: the method wm8731_i2c_probe() - connected to 
i2c_add_driver.probe field - isn't called and alsa says "No Soundcard 
found".


in the old style driver the method wm8731_codec_probe()  - connected to 
i2c_add_driver.attach_adapter field -  is called during initialization 
by i2c_add_driver() .

How to call wm8731_i2c_probe()? Do i miss something?

