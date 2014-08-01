From: =?UTF-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?=  <cm-hiep@jinso.co.jp>
Date: Fri, 01 Aug 2014 07:14:27 +0000
Subject: [Bug] GPIO-Rcar: Driver does not work after Unbind-rebind.
Message-Id: <53DB3E53.2000508@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm@opensource.se>, Simon Horman <simon@horms.net>
Cc: linux-gpio@vger.kernel.org, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, =?UTF-8?B?U+mWizEyL+ajruacrOOBleOCkw==?= <kuninori.morimoto.gx@renesas.com>, SH-Linux <linux-sh@vger.kernel.org>

Hello,

I tested gpio-rcar driver at Linux-upstream-v3.16-rc5 on Lager.
When I tried to unbind and then rebind the device, error messages occur. 
Then
gpio-rcar did not work and interrupt number did not count up any more.

The error messages is showed as below:
"irq 0, desc: ee005040, depth: 1, cou0
->handle_irq():  c005eea0, handle_bad_irq+0x0/0x21c
->irq_data.chip(): c05de7f8, 0xc05de7f8
->action():   (null)
    IRQ_NOPROBE set
  IRQ_NOREQUEST set
irq 0, desc: ee005040, depth: 1, count: 0, unhandled: 0
->handle_irq():  c005eea0, handle_bad_irq+0x0/0x21c
->irq_data.chip(): c05de7f8, 0xc05de7f8
->action():   (null)
    IRQ_NOPROBE set
  IRQ_NOREQUEST set"

Please see it and fix this bug.


Best regards,
JINSO/Cao Minh Hiep.

