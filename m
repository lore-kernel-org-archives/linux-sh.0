From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 09 Feb 2008 02:58:40 +0000
Subject: Re: How can I test a joystick type device?
Message-Id: <20080209025840.GA20012@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1202514806.6237.1.camel@localhost.localdomain>
In-Reply-To: <1202514806.6237.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 08, 2008 at 11:53:26PM +0000, Adrian McMenamin wrote:
> As below shows I think I have successfully ported the 2.4 Dreamcast
> controller driver to 2.6 - but how can I test it? Is there a device I
> should be looking for in /dev that I could just cat?
> 
Other than the existing suggestion, you can also use evdev for just
cat'ing and getting the raw events.
