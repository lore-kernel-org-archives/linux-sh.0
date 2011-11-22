From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 22 Nov 2011 14:21:55 +0000
Subject: Re: SH2a Write-back cache issue
Message-Id: <1321971715.9828.8.camel@AURIO02>
List-Id: <linux-sh.vger.kernel.org>
References: <201111221415.22367.andrea.baldini@spesonline.com>
In-Reply-To: <201111221415.22367.andrea.baldini@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Federico, I think you could help Andrea about this issue.
Regard

Il giorno mar, 22/11/2011 alle 14.15 +0100, Andrea Baldini ha scritto:
> Hi,
> 
> I'm working on a sh7203 board and I'm currently using a 2.6.28 kernel with a 
> write-back cache mode configuration.
> When this configuration is set I got some issues when the flush_icache_range is 
> involved.
> 
> /* O-Cache writeback */
> for (way = 0; way < 4; way++) {
> unsigned long data =  ctrl_inl(CACHE_OC_ADDRESS_ARRAY | addr | (way << 11));
> 	if ((data & CACHE_PHYSADDR_MASK) = (v & CACHE_PHYSADDR_MASK)) {
> 		data &= ~SH_CACHE_UPDATED;
> 		ctrl_outl(data, CACHE_OC_ADDRESS_ARRAY | addr | (way << 11));
> 	}
> }
> 
> When the O-cache writeback is performed all system interrupts are missed, 
> including the timer one.
> This occurs, for instance, when a flat binary is loaded in memory ( 
> load_flat_file() ) or when a signal is handled ( when setting up a frame ).
> 
> This is an unacceptable behaviour for the system. 
> A workaround is setting a write-through configuration to the kernel and flushing 
> just the instruction cache entries.
> 
> I've seen the recent kernel releases but it seems this part hasn't been 
> modified yet.
> Anyway i tried a 2.6.35 kernel version some time ago and i got the same 
> problems.
> 
> Is anybody here working on this issue?
> Is it possible to use the write-back configuration?
> 
> Regards
> 
> Andrea
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Fabio Giovagnini

Aurion s.r.l.
P.iva 00885711200
cell. +39.335.8350919
Tel. +39 051.082.69.65
Fax. +39 051.082.14.49
skype: aurion.giovagnini


