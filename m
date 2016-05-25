From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 25 May 2016 13:18:06 +0000
Subject: Re: [PATCH v3 01/12] of: add vendor prefix for J-Core
Message-Id: <CAL_JsqKWq-DBQMWof6hyh0_sS4OPOP7afJXYdaWTiqf15MpKAg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org> <b6d33800300bde8f1d9a7b88a715d741548fad4a.1464148904.git.dalias@libc.org>
In-Reply-To: <b6d33800300bde8f1d9a7b88a715d741548fad4a.1464148904.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>

On Wed, May 25, 2016 at 12:43 AM, Rich Felker <dalias@libc.org> wrote:
> The J-Core project (j-core.org) produces open source cpu and SoC
> peripheral cores synthesizable as FPGA bitstreams or ASICs.
>
> Signed-off-by: Rich Felker <dalias@libc.org>

Please add acks when posting subsequent versions.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 86740d4..9c070b8 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -126,6 +126,7 @@ invensense  InvenSense Inc.
>  isee   ISEE 2007 S.L.
>  isil   Intersil
>  issi   Integrated Silicon Solutions Inc.
> +jcore  J-Core.org
>  jedec  JEDEC Solid State Technology Association
>  karo   Ka-Ro electronics GmbH
>  keymile        Keymile GmbH
> --
> 2.8.1
>
>
