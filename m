From: Conrad Parker <conrad@metadecks.org>
Date: Thu, 29 Jul 2010 11:16:43 +0000
Subject: Re: Coherent memory allocator
Message-Id: <AANLkTinB=VSSRDusH9FhOx5sk0keFEUm=aEb=OS-g_zg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTinQHQOATkLVc+v+mWBzc3rprnA11yvLmMOmBhuM@mail.gmail.com>
In-Reply-To: <AANLkTinQHQOATkLVc+v+mWBzc3rprnA11yvLmMOmBhuM@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 29 July 2010 19:50, Andrew Murray <amurray@mpcdata.com> wrote:
> Hello,
>
> Whilst trying to reduce boot time on an SH kernel I noticed the
> coherent memory allocator (dma_generic_alloc_coherent) in
> arch/sh/mm/consistent.c always memset's the memory it allocates to 0 -
> regardless of the user's intention (i.e use of __GFP_ZERO flag as
> argument).
>
> I would expect this function to not memset it's memory and instead
> allow the user to specify if they want the memory zeroed through the
> gfp flags. This would ensure memory is only zeroed when required - and
> when it is required the __get_free_pages implementation uses the more
> efficient clear_page implementation.
>
> However removing the memset may break drivers than rely on zeroed
> memory even though they don't request it.
>
> Is my reasoning valid? Shall I submit a patch?

I have no idea if your reasoning is valid, but in general if you send
a patch to the list then it makes it easier for anyone who might be
affected to test if their environment breaks ... no need to ask for
permission to send a patch :)

Conrad.
