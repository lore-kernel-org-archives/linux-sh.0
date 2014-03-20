From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Mar 2014 19:04:22 +0000
Subject: Re: DMABOUNCE in pci-rcar
Message-Id: <CAMuHMdX0kZhJyJFCQK7MUbv3nnKbqLkEJ2gnWMuHLSGLQvuQ2A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201402241200.21944.arnd@arndb.de>
 <20140320173106.GA19395@obsidianresearch.com>
 <532B2628.5080305@codethink.co.uk>
 <201403201929.13633.arnd@arndb.de>
 <20140320183932.GA7528@n2100.arm.linux.org.uk>
In-Reply-To: <20140320183932.GA7528@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Russell,

On Thu, Mar 20, 2014 at 7:39 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> That all said, what I find most annoying is that Ben has ignored my
> question about exactly what the nature of the limitation is on this
> platform.  My response to that is - if you're not going to do the
> curtesy of answering such a simple question, then you don't get to
> patch the kernel for this problem.

Ben did answer:
"If the window is set to 2GiB it can only access 2GiB aligned to 2GiB
 boundary, however DRAM spans a 2GiB boundary (being at 1-3GiB)"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
