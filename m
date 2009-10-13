From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 13 Oct 2009 13:08:03 +0000
Subject: Re: Possibly icahe/dcache synchronization problem on sh7785lcr
Message-Id: <20091013130803.GB31887@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4ACF32C2.9010501@siemens.com>
In-Reply-To: <4ACF32C2.9010501@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 13, 2009 at 04:44:19PM +0400, Valentin R Sitsikov wrote:
> How do you think if it is possible to use only one loop
> and ocbwb/ocbi/ocbp with virtual address instead of associative writing 
> to all ways?
> Or there are some restriction on doing that ?
> 
On SH-4A there are no restrictions, so that's actually the direction that
we want to move in. In the case of legacy SH-4 parts, ocbwb and friends
to arbitrary virtual addresses is not supported, so it must use the
associative write through the address array. If you hack up something
that works for you on SH-4A though we can of course overload the SH-4
version, and then backpedal from that. The ordering is not so important,
the fact that your workload is able to trigger bugs that mine isn't is!
;-)
