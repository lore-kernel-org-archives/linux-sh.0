From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 22 Jan 2016 10:32:28 +0000
Subject: RE: [RFC 0/6] mmc: sdhi: add basic r8a7795 support
Message-Id: <SG2PR06MB0919D38E8BDB5F8B1A419F43D8C40@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Dirk-san, Wolfram-san,

> > And third, from reading the r8a7795 manual I think the manual talks about
> >
> > https://github.com/dirkbehme/linux-renesas-rcar-gen3/commit/f2a727c859916d59dca85dbb72c1b61da3fd6da0
> >
> > But testing this it doesn't work. So either the manual is wrong, or I missed
> > anything else.
> 
> I have seen this patch and my gut feeling is that it won't make a
> difference? SCLKDIVEN is like CBUSY plus some more cycles AFAIU. But I
> am not working on DMA issues now, this has to wait.

I'm not sure we have to use CBSY bit instead of SCLKDIVEN on r8a7795.
However, I could use the CBSY bit if I used the following code.

	while (--timeout && (sd_ctrl_read16(host, CTL_STATUS2) & (1 << 14)))

If we use the CBSY bit, I think we have to wait while the CBSY bit is set to 1.
(In other words, the behavior of CBSY bit is different from the SCLKDIVEN bit if my understanding is correct.)

Best regards,
Yoshihiro Shimoda

