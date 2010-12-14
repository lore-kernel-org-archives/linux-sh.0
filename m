From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 14 Dec 2010 07:23:15 +0000
Subject: Suggestion if possible about kernel debug
Message-Id: <201012140823.15706.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi All,
I should to get your opinio about the following problem I'm having just in 
these days.
I control the touch screen of my board with a very simple drive written by me 
for ADS7843 and I control a buzzer with a pwm produced by kernel using MTU2 
timer channel A.

If I write an image on the screen and I drive the buzzer in a very simple 
software derived by the bootstrap software everything works fine; if I do the 
same (writing and image on the screen and driving the buzzer) from the user 
space through the kernel I see on the screen some time few glitch of the 
image, but the image is not corrupted unreversibly.

The difference is that in the simple bootstrap I have the ram variable needed 
to manage the software PWM into the ON CHIP ram (sh2a 7203), while in the 
other case I have both ram (video ram and buizzer kernel driver ram) on top of 
SDRAM.
Can I have a problem of asynchronous ram access between LCDC and buzzer 
interrupt handler?
Where could I verify how the LCDC and a generic interrupt handler of the linux 
kernel access the SDRAM

Sorry for my question and thanks in advance


-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
