From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 21 Aug 2018 03:50:07 +0000
Subject: Re: [PATCH 13/13] sh: lib: convert to SPDX identifiers
Message-Id: <874lfoe5u8.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <874lg8p7d2.wl-kuninori.morimoto.gx@renesas.com>
        <87lg9knslt.wl-kuninori.morimoto.gx@renesas.com>
        <20180809123631.q7rxqaqaipakfdvh@verge.net.au>
        <87d0udvn6d.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d0udvn6d.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms@verge.net.au>, Rich Felker <dalias@libc.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Mon, 20 Aug 2018 10:37:49 +0900,
Kuninori Morimoto wrote:
> 
> 
> Hi Simon, Sato-san
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > This patch updates license to use SPDX-License-Identifier
> > > instead of verbose license text.
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> (snip)
> > > -In addition to the permissions in the GNU General Public License, the
> > > -Free Software Foundation gives you unlimited permission to link the
> > > -compiled version of this file into combinations with other programs,
> > > -and to distribute those combinations without any restriction coming
> > > -from the use of this file.  (The General Public License restrictions
> > > -do apply in other respects; for example, they cover modification of
> > > -the file, and distribution when not linked into a combine
> > > -executable.)
> > 
> > Given the above clause I wonder if the SPDX identifier should be:
> > 
> > SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
> 
> Ahh, indeed.
> I will post v2 patch.
> Sato-san, can I post [13/13 v2] only ? or should post all patches ?
> 

Please sent all patches.
Thanks.

-- 
Yosinori Sato
