From: Simon Horman <horms@verge.net.au>
Date: Wed, 04 Mar 2015 04:08:19 +0000
Subject: Re: [PATCH/RFC] i2c: rcar: Fix order of restart and clear status
Message-Id: <20150304040819.GB12776@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424011396-3492-1-git-send-email-ykaneko0929@gmail.com>
 <b0a6dd2b593f2f891946ef910c876b48@the-dreams.de>
In-Reply-To: <b0a6dd2b593f2f891946ef910c876b48@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-i2c@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi Wolfram,

On Mon, Feb 23, 2015 at 02:07:18PM +0100, Wolfram Sang wrote:
> Hi,
> 
> On 2015-02-15 15:43, Yoshihiro Kaneko wrote:
> >From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> >
> >In case of repeated START condition, the restart has to be kicked
> >before clear status (MSR register). If it is kicked after clear status,
> >R-Car I2C may transfer data (TXD register) or receive data (RXD register)
> >instead of transferring slave address (MAR register).
> >
> >Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> >Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> 
> Thanks for the patch!
> 
> I wondered if we couldn't always kick the start/restart before clearing
> the status register?

I asked Kataoka-san about this and his response was as follows:

If system(CPU) is busy, the driver can't clear the status register soon
after kicking start.

If sequence of first start is as follows, there is a problem.
Because H/W starts by 1.
But sequence of re-start is as follows, there is no problem.
Because H/W starts by 2.

  1. Issue START condition by ESG bit of ICMCR register.
                  <--- If there is too much time, H/W finish transmitting
                       and set status in status register.
  2. Clear interrupt status (ICMSR).
  3. Open interrupt mask.
  4. Wait interrupt.
                  <--- If status is cleared, interrupt does not occur.

> I am not sure if this simulates the flaw accurately, but I inserted a
> udelay(500) in the original code after clearing the status register.
> Then, I couldn't access the audio codec on my Lager board anymore. By
> always first "kicking" and then clearing, access was possible again. But
> as said, I am not sure if my scenario matches yours. Have you considered
> to treat start and repeated start the same and always kick the condition
> before clearing the status?
