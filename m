From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 21 Dec 2008 06:17:04 +0000
Subject: Re: [PATCH] sh: maple: Robust checking for errors on maple keyboard initialisation
Message-Id: <200812202217.05002.dmitry.torokhov@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1229797527.6502.18.camel@localhost.localdomain>
In-Reply-To: <1229797527.6502.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: lkmL <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Matt Fleming <matt@console-pimps.org>, Andrew Morton <akpm@osdl.org>

On Saturday 20 December 2008 10:25:27 Adrian McMenamin wrote:
> As was pointed out in response to http://lkml.org/lkml/2008/12/19/373
> maple drivers were not properly checking for NULL pointers.
>
> This patch fixes this for the keyboard driver already in mainline.
>

This driver is fine as is, only the joystick driver had the issue.

-- 
Dmitry
