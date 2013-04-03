From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 03 Apr 2013 08:25:34 +0000
Subject: Re: [RFC][PATCH 0/3] ARM: shmobile: r8a7790 clock update
Message-Id: <CANqRtoQNviXzgMOeThij8idCQEDf5qdpuXPKbS5hunLcgwDbZw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehescbs5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehescbs5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thanks for your work on this.

On Wed, Apr 3, 2013 at 4:29 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Simon, Magnus
>
> These patches update r8a7790 clocks.
> But, this is just information for you at this point.
> Because current r8a7790 datasheet <--> real machine seems have mismatch
> So, I added [RFC] on this series
> I will re-send v2 if when got correct datasheet information
>
> These are based on simon/next branch,
> and, Rev 0.05 datasheet
>
> Kuninori Morimoto (3):
>       ARM: shmobile: r8a7790: add main clock
>       ARM: shmobile: r8a7790: add div4 clocks
>       ARM: shmobile: r8a7790: add div6 clocks

In general I'm ok with your clock framework changes, however that the
data sheet is not matching actual hardware is a bit worrying.

Please get back to us when you get updated data sheet information.

Thanks,

/ magnus
