From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 08 Jul 2014 06:45:51 +0000
Subject: Re: renesas-drivers-2014-07-07-v3.16-rc4
Message-Id: <CAMuHMdX0Bz9VdyGDcEykz=3BRAODO0ouSJ9ftciPG-YCe1vtjQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVTOabkGyJW-jRxXjtGHdA0W=APoiMYWAtvP3y_auqXKg@mail.gmail.com>
In-Reply-To: <CAMuHMdVTOabkGyJW-jRxXjtGHdA0W=APoiMYWAtvP3y_auqXKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Nguyen-san,

On Tue, Jul 8, 2014 at 12:35 AM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
> Could you clarify how developers should use your tree and Simon tree ?

The goal of my tree is to serve as a good base for development/testing on
shmobile platforms. It contains the latest (accepted) support code for
shmobile platforms and drivers, to be integrated in upstream releases soon.
Hence people no longer have to look around in various maintainer trees
to find shmobile driver updates that are meant for the next kernel release.

> - Currently, as my understanding, patches are developed and submitted
>   base on devel branch of Simon tree.

Yes, but this applied to patches touching the shmobile platform code only.

> - So, with your tree, patches will be developed base on your tree and you
>   and/or Simon will re-base into devel branch of Simon tree for upstream ?

Patches touching the shmobile platform code should still be sent to Simon.
Patches touching other parts of the tree should still be sent to the appropriate
maintainer, who will integrate them. There's no change in that.

I hope this answers your question. Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
