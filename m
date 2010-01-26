From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 26 Jan 2010 08:54:12 +0000
Subject: Re: USB boot problems submission
Message-Id: <20100126085412.GF2739@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4B5D3019.9080900@renesas.com>
In-Reply-To: <4B5D3019.9080900@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 26, 2010 at 05:33:18PM +0900, Yusuke Goda wrote:
> Hi Paul-san
> 
> > You should rebuild your kernel with verbose BUG reporting and all of the
> > kallsyms bits turned on, which will give you a meaningful oops. That
> I attach log(CONFIG_KALLSYMS=y).
> 
> > should at least give us an idea of where things are going wrong,
> > otherwise we go back to bisecting.
> This problem seems to occur with the following commit.
>  commit 2277ab4a1df50e05bc732fe9488d4e902bb8399a
>   sh: Migrate from PG_mapped to PG_dcache_dirty.
> 
> Sorry, I cannot identify it to number of lines.

Thanks. Can you try this again with the dwarf unwinder enabled?
