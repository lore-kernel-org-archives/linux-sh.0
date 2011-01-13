From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Jan 2011 06:50:25 +0000
Subject: Re: cache disabling
Message-Id: <20110113065025.GH12013@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201101121904.21051.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101121904.21051.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 13, 2011 at 06:28:44AM +0100, Fabio Giovagnini wrote:
> Hi Paul thanks a lot for you patience with my stupid questions.
> But it is not so surprising, because I verified in previuos kernels, that 
> disabling all the options of the cache still the file cache-<cpu_type> was 
> compiled and linked into the built-in.o file.
> This has been the reason of my question.
> Anyway if you confirm I'm really sure.
> 
I'm not sure what exactly linking has to do with anything, but a cursory
inspection of the code would have made it pretty apparent.

arch/sh/mm/cache.c shows:

void (*local_flush_cache_all)(void *args) = cache_noop;
void (*local_flush_cache_mm)(void *args) = cache_noop;
void (*local_flush_cache_dup_mm)(void *args) = cache_noop;
void (*local_flush_cache_page)(void *args) = cache_noop;
void (*local_flush_cache_range)(void *args) = cache_noop;
void (*local_flush_dcache_page)(void *args) = cache_noop;
void (*local_flush_icache_range)(void *args) = cache_noop;
void (*local_flush_icache_page)(void *args) = cache_noop;
void (*local_flush_cache_sigtramp)(void *args) = cache_noop;

....
void __init cpu_cache_init(void)
{
        unsigned int cache_disabled = 0;

#ifdef CCR
        cache_disabled = !(__raw_readl(CCR) & CCR_CACHE_ENABLE);
#endif

        /*
         * No flushing is necessary in the disabled cache case so we can
         * just keep the noop functions in local_flush_..() and __flush_..()
         */
        if (unlikely(cache_disabled))
                goto skip;

	...

skip:
        emit_cache_params();
}

I really shouldn't need to paste completely obvious code paths that have
already been documented to outline what happens in the case you describe.  Next
time you have a question like this, rather than opening up your mailer, how
about opening up your text editor and just looking at the code?

Contrary to popular belief, I don't generally comment code for my own benefit,
and it's becoming increasingly obvious that it's not of much benefit to people
who can't be bothered to read, either.

In the future, do not expect answers to questions you can easily answer
yourself.
