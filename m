From: Harley Laue <losinggeneration@aim.com>
Date: Sat, 09 Feb 2008 01:18:35 +0000
Subject: Re: How can I test a joystick type device?
Message-Id: <200802081918.36281.losinggeneration@aim.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1202514806.6237.1.camel@localhost.localdomain>
In-Reply-To: <1202514806.6237.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday 08 February 2008 05:53:26 pm you wrote:
> As below shows I think I have successfully ported the 2.4 Dreamcast
> controller driver to 2.6 - but how can I test it? Is there a device I
> should be looking for in /dev that I could just cat?
Cool. 
if a /dev/input/js? or /dev/js? does not show up you can try:
mknod js0 c 13 0
then you can cat js0 and move the joystick to see if it's working
