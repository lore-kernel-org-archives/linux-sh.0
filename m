From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Tue, 18 Sep 2012 02:15:24 +0000
Subject: Re: irqdomain breaks ap4 boot
Message-Id: <5057D93C.8020902@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul-san,

(2012/08/31 19:36), Paul Mundt wrote:
> On Fri, Aug 31, 2012 at 04:17:16PM +0900, Simon Horman wrote:
>> Hi Kobayashi-san,
>>
>> I'd rather only apply patches that are ready for upstream.
>> Is this patch suitable for merging upstream?
>>
> Yes, it's already in my tree and Linus-bound, I just haven't sent it yet
> as I was waiting to see if anything else was broken first. The multi-evt
> case is pretty uncommon, so there shouldn't be many platforms that even
> care about this (I'd be surprised if anything on the ARM side does for
> example).
>
Could you post this patch ?

