From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 03 Jul 2012 13:44:32 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <Pine.LNX.4.64.1207031537380.29890@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 3 Jul 2012, Mark Brown wrote:

> On Tue, Jul 03, 2012 at 02:44:33PM +0200, Guennadi Liakhovetski wrote:
> 
> > Well, I'm not sure what approach would be the preferred by the 
> > maintainers, how about the diff below. If it is acceptable, I'll split it 
> > into 2 patches and submit properly.
> 
> This doesn't seem right.  If this is useful we should just remove the
> configuration for the fixed voltage regulator entirely as there's
> nothing platform specific about this, and we probably ought to be going
> through all the boards using "real" regulators adding selects for their
> drivers too.

Hm, why? Let's take smsc911x. The driver needs "some" regulators for its 
two power pins. On different systems different regulators are used for 
those supplies. It just happens to be the case, that many sh and 
arm/mach-shmobile platform use the fixed voltage regulator for smsc911x 
(and other devices). In principle every such board should enable the fixed 
regulator individually. But, since there are several of them, I just 
proposed a shortcut. Otherwise, if on some other board a different 
regulator is used to supply power to devices, enabling the fixed voltage 
regulator will not help in any way. To actually make that system work 
it'll need to enable the respective regulator.

So, I think, the absolutely correct fix would be to add that "select" 
statement to each affected board individually. But maybe enabling it for 
sh and shmobile in general will be accepted as a reasonable alternative.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
