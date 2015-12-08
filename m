From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Dec 2015 00:08:28 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: bockw dts: Override #sound-dai-cells to zero
Message-Id: <87a8pl7qjw.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449505537-15428-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449505537-15428-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org


Hi

> The default value of #sound-dai-cells in r8a7778.dtsi is one, while
> the /sound/simple-audio-card,cpu device node in r8a7778-bockw.dts uses a
> phandle without any extra cells ("<&rcar_sound>"), causing:
> 
>     /sound/simple-audio-card,cpu: arguments longer than property
>     asoc-simple-card sound: parse error -22
>     asoc-simple-card: probe of sound failed with error -22
> 
> Override #sound-dai-cells to zero to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> The rcar_sound node is still disabled. So why is this needed?!?

This error came from "simple-audio-card", not "rcar_sound" I think.
# sound needs many drivers...

Actually, I don't want to have default #sound-dai-cells in r8a7778.dtsi.
Like below. I will send this patch soon

ad63241cdc328edbb0f879416ea7707bf0997f08
("ARM: shmobile: r8a7790: tidyup #sound-dai-cells settings")

