From: "Pietrek, Markus" <Markus.Pietrek@emtrion.de>
Date: Thu, 04 Feb 2010 08:11:55 +0000
Subject: AW: [PATCH] sh: added PWM driver for SH7723 using the TPU
Message-Id: <95F51F4B902CAC40AF459205F6322F0171E8D49A61@BMK019S01.emtrion.local>
List-Id: <linux-sh.vger.kernel.org>
References: <95F51F4B902CAC40AF459205F6322F0171E8D499FD@BMK019S01.emtrion.local>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F0171E8D499FD@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

Thank you for your comments. Yet the 2 issues listed below are inherited from the only other pwm implementations in arch/arm/plat-{pxa,s3c,mxc}.

> > +EXPORT_SYMBOL(pwm_disable);
> > +
> Is EXPORT_SYMBOL() intentional? By convention we primarily use
> EXPORT_SYMBOL_GPL() for new exports.

And

> arch_initcall() is a bit early, presumably you have some users of this
> code that actually needs to have this initialized that early on?

Peronally I would have used subsys_initcall if it was not for the other implementations.

Best regards,
Markus

_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or otherwise confidential information.
- If you have received this e-mail in error, you are hereby notified that any review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.
