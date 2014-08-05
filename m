From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 05 Aug 2014 01:05:04 +0000
Subject: Re: [Bug] GPIO-Rcar: Driver does not work after Unbind-rebind.
Message-Id: <11539044.7ozDkqgRA7@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <53DB3E53.2000508@jinso.co.jp>
In-Reply-To: <53DB3E53.2000508@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: cm-hiep@jinso.co.jp
Cc: Magnus Damm <damm@opensource.se>, Simon Horman <simon@horms.net>, linux-gpio@vger.kernel.org, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, =?utf-8?B?U+mWizEyL+ajruacrOOBleOCkw==?= <kuninori.morimoto.gx@renesas.com>, SH-Linux <linux-sh@vger.kernel.org>

Hello,

On Friday 01 August 2014 16:14:27 カオ　ミン　ヒェップ wrote:
> Hello,
> 
> I tested gpio-rcar driver at Linux-upstream-v3.16-rc5 on Lager.
> When I tried to unbind and then rebind the device, error messages occur.
> Then gpio-rcar did not work and interrupt number did not count up any more.
> 
> The error messages is showed as below:
> "irq 0, desc: ee005040, depth: 1, cou0
> ->handle_irq():  c005eea0, handle_bad_irq+0x0/0x21c
> ->irq_data.chip(): c05de7f8, 0xc05de7f8
> ->action():   (null)
>     IRQ_NOPROBE set
>   IRQ_NOREQUEST set
> irq 0, desc: ee005040, depth: 1, count: 0, unhandled: 0
> ->handle_irq():  c005eea0, handle_bad_irq+0x0/0x21c
> ->irq_data.chip(): c05de7f8, 0xc05de7f8
> ->action():   (null)
>     IRQ_NOPROBE set
>   IRQ_NOREQUEST set"
> 
> Please see it and fix this bug.

Could you please detail the procedure to follow to reproduce the problem ?

-- 
Regards,

Laurent Pinchart

