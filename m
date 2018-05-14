From: Rob Herring <robh@kernel.org>
Date: Mon, 14 May 2018 20:01:16 +0000
Subject: Re: [PATCH] sh: switch to NO_BOOTMEM
Message-Id: <CAL_JsqLWDfCOAzeKP7hM3yGONRU_AKhM1oJHZ7GyzTLNT6EQJw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180511134559.13464-1-robh@kernel.org> <20180514120343.GB5265@infradead.org>
In-Reply-To: <20180514120343.GB5265@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Rich Felker <dalias@libc.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Mon, May 14, 2018 at 7:03 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> unflattening could also fix this, but removing bootmem is desired. So
>> enable NO_BOOTMEM on SH like other architectures have done.
>
> Can you send out similarly shoot in the wild conversion for the
> remaining architectures while you are at it?  We still seem to be
> missing: alpha, c6x, hexagon, ia64, m68k, mips, nios2 and unicore32.

Sparc (32-bit only) too.

I might be talked into the remaining arches that support DT which
would be c6x, hexagon, mips, and nios2. Though, looking at the MIPS
arch code always makes me cry (just try "git grep 'bootmem'
arch/mips/").

Rob
