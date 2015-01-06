From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 06 Jan 2015 10:55:36 +0000
Subject: Re: [PATCH 2/2] thermal: rcar: change type of ctemp in rcar_thermal_update_temp()
Message-Id: <CAMuHMdUcW=eNqcm7fRxSyYna+66kwNdXoc6370b6CFDp8-eqSQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420538528-5236-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1420538528-5236-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1420538528-5236-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Jan 6, 2015 at 11:02 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Since the ctemp is used for rcar_thermal_write() in
> rcar_thermal_update_temp(), the type of ctemp should be "u32" instead
> of "int".
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
