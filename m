From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Date: Mon, 26 Apr 2010 10:41:13 +0000
Subject: Re: Hi guys, does any of you have experience with touchscreen controllers?
Message-Id: <4BD56DC9.3070103@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
References: <201004222004.38724.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004222004.38724.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

hi fabio,

Fabio Giovagnini wrote:
> Hi Dale, 
> maybe I need to be more clear about my condition.
> 1) I connected the ads7843 to general I/O ports because the SPIs available on 
> sh2a7203 have been be used for other functions;
It is not a big problem, you can also bitbang on the gpio pin.

> 2) My real problem is the following: I wrote an ADS7843 device driver as a 
> button driver of the input subsystem. I configured the ads7843 with INT 
> enabled; so when the touch is pressed I have a burst of IRQ. The IRQ handler 
> read the ads7843 and return to the input subsystem the abs values of the 
> touchscreen.
I think tha rewrite the code it is not so usefull but reuse the code 
using a bitbang interface
it's more simple and don't need a lot of testing

Michael Trimarchi
