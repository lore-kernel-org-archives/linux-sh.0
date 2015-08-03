From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 03 Aug 2015 16:56:59 +0000
Subject: Re: [PATCH 0/4 v3][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <CAMuHMdUybLQ=KvUBnSONA2KGQHPngPKkn+YWgw-tN2C9T1rjig@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877fpdw3av.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877fpdw3av.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Simon et al,

On Mon, Aug 3, 2015 at 8:59 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Aug 03, 2015 at 11:44:14AM +0900, Simon Horman wrote:
>> I plan to queue these up in a topic branch, topic/arm64-rcar-gen3-v3,
>> of the renesas tree. I plan for the base of the branch to be v4.2-rc1,
>> currently the base for work I have queued up up for v4.2 (I am not
>> queuing up this series for v4.2 at this time). Please let me know
>> if a different base, e.g. v4.1, would be more appropriate.
>
> I have pushed the topic/arm64-rcar-gen3-v3 branch as described above.

That branch is not included in renesas-devel-20150803-v4.2-rc5.
Is that intentional?

Please note that arm-soc/for-next contains commits eed6b3eb20b97bef ("arm64:
Split out platform options to separate Kconfig", [1]) and fbac1c81e2591c5d
("arm64: add Rockchip architecture entry", [2]), causing merge conflicts.

Nothing I can't handle myself (for now), though...

[1] https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=
=3Dfor-next&id=EEd6b3eb20b97beff66ca59bb610ac73532278ee
[2] https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=
=3Dfor-next&id=FBac1c81e2591c5d1e5abd9a4477002f2afd0ab4

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
