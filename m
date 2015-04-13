From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Apr 2015 12:18:16 +0000
Subject: PM / Domains: Infinite loop during reboot
Message-Id: <CAMuHMdVAnZ5mH7EwJKVeKWSDqCxn+TSH1VOHoK3B2=b8oByoHg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>

Sometimes reboot doesn't work on r8a7791/koelsch with the CPG clock domain.
With additional debug messages, you can see it hangs in an infinite loop:

rcar-dmac ec720000.dma-controller: removing from PM domain cpg_clocks
pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
pm_genpd_remove_device: Remove ec720000.dma-controller from cpg_clocks
[...]

Presumably this is this loop in genpd_dev_pm_detach():

        while (1) {
                ret = pm_genpd_remove_device(pd, dev);
                if (ret != -EAGAIN)
                        break;
                cond_resched();
        }

which is retried because genpd->prepared_count > 0 in pm_genpd_remove_device().
This looks a bit strange, as no suspend is in progress, so prepared_count
should be zero?

I'm adding more debugging code to verify this, but it's not 100% reproducable.

[...]

Confirmed: prepared_count turns out to be 1 at reboot time if at least one
s2ram cycle happened before. Additional s2ram cycles don't seem to increase
prepared_count any further.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
