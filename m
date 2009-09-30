From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 30 Sep 2009 02:20:31 +0000
Subject: Re: currect MigoR seems doesn't work
Message-Id: <uiqf19nrk.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> But MigoR still doesn't work now.
> I need debug for it...

I searched MigoR dead process.
But I'm not sure why.

start_kernel
 setup_arch
  setup_memory
   setup_bootmem_allocator
    for()
      reserve_bootmem (when i=2 I think)
       mark_bootmem
        BUG()          <= dead here and reboot MigoR

Best regards
--
Kuninori Morimoto
 
