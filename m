From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 17 Apr 2013 16:16:30 +0000
Subject: Re: [PATCH v2] sh-pfc: R8A7779: add VIN pin groups
Message-Id: <CACRpkdZR6hr77O3j3AEaVDPecue+LU9vPfOXtvTuTDLMpfF24w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304170216.19353.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304170216.19353.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 17, 2013 at 12:16 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>
> Add VIN DATA[0:7]/CLK/HSYNC/VSYNC pin groups to R8A7779 PFC driver.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> These pins will be needed by the upcoming R-Car VIN driver...
> The patch is atop of Simon's 'renesas.git' tree, 'renesas-next-20130416' tag.
>
> Changes from the original posting:
> - replaced hardcoded pin numbers with RCAR_GP_PIN() macro invocations;
> - clarified the changelog;
> - lowercased the SoC name in the subject.

Acked-by if and only if Laurent also ACKs it.

Yours,
Linus Walleij
