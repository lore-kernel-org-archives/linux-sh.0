From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Jan 2019 18:20:15 +0000
Subject: Re: [PATCH 4/7] sh_eth: offload RX checksum on R8A7740
Message-Id: <CAMuHMdUixqEcD36ReZj4noF5VOCNHS-qH_9herABkiLSVD3R8A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com> <e43f07fd-1407-a87a-7fe5-67a522da9e19@cogentembedded.com>
In-Reply-To: <e43f07fd-1407-a87a-7fe5-67a522da9e19@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Sergei,

On Sun, Jan 27, 2019 at 6:41 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The R-Mobile A1 (R8A7740) SoC manual describes the Ether MAC's RX checksum
> offload the same way as it's implemented in the EtherAVB MAC...
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks for your patch!

Running netperf as described in patch 2/7, perf tells me there's a reduction
for csum_partial from ca. 1.9% to 0.01%, so this feature seems to work.

Hence:
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

However, while effective according to perf results, using ethtool to
enable/disable
the feature prints an error message:

root@armadillo:~# ethtool -K eth0 rx on
Cannot get device udp-fragmentation-offload settings: Operation not supported
Cannot get device udp-fragmentation-offload settings: Operation not supported
root@armadillo:~# ethtool -K eth0 rx off
Cannot get device udp-fragmentation-offload settings: Operation not supported
Cannot get device udp-fragmentation-offload settings: Operation not supported
root@armadillo:~#

Do you have any clue?

Does this needs testing on R-Mobile A1 with VLAN enabled, too, or is that
independent from the underlying sh-eth hardware version?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
