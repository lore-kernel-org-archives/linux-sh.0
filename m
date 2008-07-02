From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Date: Wed, 02 Jul 2008 07:43:19 +0000
Subject: Re: [PATCH 06/07] videobuf: Add physically contiguous queue code
Message-Id: <486B3197.5000100@teltonika.lt>
List-Id: <linux-sh.vger.kernel.org>
References: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>
	<20080701124735.30446.89320.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080701124735.30446.89320.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: video4linux-list@redhat.com
Cc: linux-sh@vger.kernel.org

Heh. I have written almost identical videobuf driver also :)
You should run checkpatch.pl on this patch to correct some style
problems. Since your version is a little bit more generic than mine:

Acked-by: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>

Magnus Damm wrote:
> This patch adds support for videobuf queues made from physically
> contiguous memory. Useful for hardware such as the SuperH Mobile CEU
> which doesn't support scatter gatter bus mastering.
> 
> Since it may be difficult to allocate large chunks of physically
> contiguous memory after some uptime due to fragmentation, this code
> allocates memory using dma_alloc_coherent(). Architectures supporting
> dma_declare_coherent_memory() can easily avoid fragmentation issues
> by using dma_declare_coherent_memory() to force dma_alloc_coherent()
> to allocate from a certain pre-allocated memory area.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

