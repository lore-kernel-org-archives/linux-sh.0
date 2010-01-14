From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 Jan 2010 23:29:33 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: Add motion sensor driver support
Message-Id: <20100114232932.GA25018@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4B4EE985.3090908@renesas.com>
In-Reply-To: <4B4EE985.3090908@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 14, 2010 at 06:53:09PM +0900, NISHIMOTO Hiroki wrote:
> This patch adds support for lis3lv02d motion sensor driver
> that use i2c interface to the Ecovec board.
> 
> I tested the driver with 'evtest' which is available
> from a below link.
> http://beagleboard.googlecode.com/files/evtest.c
> 
> Signed-off-by: NISHIMOTO Hiroki <nishimoto.hiroki@renesas.com>

This patch had its whitespace badly damaged by your mailer. I've applied
it manually this time, but please look over Documentation/email-clients.txt
for suggestions on how to fix this for future patch submissions.
