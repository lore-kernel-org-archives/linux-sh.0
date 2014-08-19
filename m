From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Aug 2014 06:48:35 +0000
Subject: Re: [PATCH v2 0/5] ARM: shmobile: r8a7740: add clocks to DT
Message-Id: <CANqRtoSS91FxVZnt7_pkfXtG3LvO=n=m0FaXQvX9F+8goEEWSg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1407507792-8121-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1407507792-8121-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: "Simon Horman [Horms]" <horms@verge.net.au>, SH-Linux <linux-sh@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Ulrich,

On Fri, Aug 8, 2014 at 11:23 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Hi!
>
> Here's the r8a7740 DT clock patch(es) with the changes requested by Simon
> and Magnus as specified below.  Enjoy!
>
> changes since v1:
> - split up into separate patches
> - added MSTP clock assignments

Looking great, very easy to review IMO! I guess some people may prefer
to have the patches merged into fewer ones somehow, but if it is up to
me then I take over-splitted patches over overly-complex ones any day!

> Ulrich Hecht (5):
>   ARM: shmobile: r8a7740: document MSTP clock support
>   ARM: shmobile: r8a7740: clock register bits
>   ARM: shmobile: r8a7740: add SoC clocks to DTS
>   ARM: shmobile: r8a7740: add MSTP clock assignments to DT
>   ARM: shmobile: armadillo800eva-reference: add clock overrides to DTS

For patch 1-5 above:
Acked-by: Magnus Damm <damm+renesas@opensource.se>

Cheers,

/ magnus
