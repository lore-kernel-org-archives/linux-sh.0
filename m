From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 30 Sep 2009 02:24:19 +0000
Subject: Re: currect MigoR seems doesn't work
Message-Id: <20090930022418.GA25971@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 30, 2009 at 11:20:31AM +0900, Kuninori Morimoto wrote:
> > But MigoR still doesn't work now.
> > I need debug for it...
> 
> I searched MigoR dead process.
> But I'm not sure why.
> 
> start_kernel
>  setup_arch
>   setup_memory
>    setup_bootmem_allocator
>     for()
>       reserve_bootmem (when i=2 I think)
>        mark_bootmem
>         BUG()          <= dead here and reboot MigoR
> 
Do you have NUMA support enabled? It's possible the LMB changes impacted
that.
