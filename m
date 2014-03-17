From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2014 09:22:37 +0000
Subject: Re: [PATCH] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <CAMuHMdU4vsp3onwDMeBqo0daJN258mxCzjsEMEy-iWn1zQj=wA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Fri, Mar 14, 2014 at 8:00 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> It seems the pm_rumtime work queue is causing the device to be suspended
> during initialisation, thus the initialisation may not be able to access
> registers properly. Use pm_runtime_get_sync() and pm_runtime_put_sync()
> to ensure that the pm system does not suspend it during the probe() call.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thanks, this fixes the "imprecise external abort" on Koelsch.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
