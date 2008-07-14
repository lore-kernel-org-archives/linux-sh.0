From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Date: Mon, 14 Jul 2008 12:20:34 +0000
Subject: Re: [PATCH 04/06] videobuf: Add physically contiguous queue code
Message-Id: <487B4492.2020301@teltonika.lt>
List-Id: <linux-sh.vger.kernel.org>
References: <20080714120204.4806.87287.sendpatchset@rx1.opensource.se>
	<20080714120240.4806.15664.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080714120240.4806.15664.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: video4linux-list@redhat.com
Cc: linux-sh@vger.kernel.org

Magnus Damm wrote:
> This is V3 of the physically contiguous videobuf queues patch.
> Useful for hardware such as the SuperH Mobile CEU which doesn't
> support scatter gatter bus mastering.
                   gather
                      ^
> 
> Since it may be difficult to allocate large chunks of physically
> contiguous memory after some uptime due to fragmentation, this code
> allocates memory using dma_alloc_coherent(). Architectures supporting
> dma_declare_coherent_memory() can easily avoid fragmentation issues
> by using dma_declare_coherent_memory() to force dma_alloc_coherent()
> to allocate from a certain pre-allocated memory area.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Tested-by: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>

