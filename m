From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 16 Sep 2008 18:18:06 +0000
Subject: Re: [alsa-devel] Audio buffer mmap-ing on sh arch vs. cache aliasing	problem
Message-Id: <s5h63owgdk1.wl%tiwai@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1220527434.3299.2074.camel@bri1004.bri.st.com>
In-Reply-To: <1220527434.3299.2074.camel@bri1004.bri.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pawel MOLL <pawel.moll@st.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org

At Thu, 04 Sep 2008 12:23:54 +0100,
Pawel MOLL wrote:
> 
> Hi Guys,
> 
> Recently I was investigating an issue with capturing audio using USB
> Audio Class device on a sh4-based board. "Bad voice quality" was
> reported...
> 
> Finally I have traced the problem to something which is (unfortunately)
> well known to sh developers as a D-cache aliasing (or synonym) problem. 
> 
> Briefly speaking: due to some MMU design decisions, one can have two
> different virtual address pointing to the same physical location, which
> is fine, but going via different cache slots! So if there was a value of
> "0" in the memory and user "A" will write "1" there, user "B" will still
> read "0"...
> 
> The solution is to ensure all TLB entries (so virtual memory areas) are
> beginning from a 16kB-aligned virtual address. Otherwise it is necessary
> to flush the cache between accesses from "A" and "B" sides.
> 
> And now. The USB Audio Class driver (sound/usb/usbaudio.c) is allocating
> the sound buffer like this...
> 
> static int snd_pcm_alloc_vmalloc_buffer(struct snd_pcm_substream *subs, size_t size)
> {
> [...]
> 	runtime->dma_area = vmalloc(size);
> [...]
> }
> 
> ... and vmalloc will return a page(4k)-aligned pointer, possibly not
> 16k-aligned one. This is the source of all evil ;-) 

Well, the main problem is the cache coherency with mmap in general,
and not about the page size.  The 4k and 16k things are just a
coincidence, I'd say.

> When using RW transfers everything is fine, as data is memcopied between
> two independent buffers.
> 
> In a case of MMAP mode we will end up with such a situation:
> 
> 1. The driver will memcpy data from an URB to the buffer. It will
> populate several cache lines. Let's call it a "kernel cache".
> 2. As the library has mapped the non-16k-aligned address via different
> cache line ("user cache"), it will read some rubbish from the physical
> memory, populating the "user cache" by the way.
> 3. Some time later the "kernel cache" is flushed, writing the data to
> the memory.
> 4. Some new data from URB is entering "kernel cache".
> 5. The library will access mmap-ed area again, going via the "user
> cache", which may or may not reflect the correct data (depending on the
> fact was the "user cache" flushed or not) etc.
> 
> Of course this cycle is completely not deterministic, so some of the
> "kernel cache" lines will be flushed before being accessed from user
> space, other not... The final effect is... hmm... bizarre :-) First, of
> course, you will get a (probably loud) glitch (rubbish from buffer's
> underlying memory, before the first valid data is written back), and
> then something that could be described as an "echo" ;-) I mean - you are
> capturing "1 2 3 4 5 6 7..." and the result is (G stands for Glitch ;-)
> "G 1 23 3 4 4 6 67..."
> 
> As a quick-and-dirty work-around I have modified
> snd_pcm_alloc_vmalloc_buffer() to allocate always 12kB more and then use
> 16k-aligned pointer:
> 
> static int snd_pcm_alloc_vmalloc_buffer(struct snd_pcm_substream *subs, size_t size)
> {
>         struct snd_pcm_runtime *runtime = subs->runtime;
>         if (runtime->dma_addr) {
>                 if (runtime->dma_bytes >= size)
>                         return 0; /* already large enough */
>                 vfree((void *)runtime->dma_addr);
>         }
>         runtime->dma_addr = (unsigned long)vmalloc(size + 12 * 1024);
>         if (!runtime->dma_addr)
>                 return -ENOMEM;
>         runtime->dma_area = (void *)ALIGN(runtime->dma_addr, 16 * 1024);
>         runtime->dma_bytes = size;
>         return 0;
> }
> 
> Of course it cannot be regarded as anything more as a hack. And
> definitely not as a solution... So my question is:
> 
> Any idea how the "proper solution" should look like? I see no obvious
> method to get an arch-independent "mmap-compliant" buffer. This problem
> was found on a sh arch, using an USB Audio Class device, however out
> there some other architectures are suffering from this MMU "feature" as
> well (ie. see http://docs.hp.com/en/B3906-90006/ch07s09.html) and
> possibly other drivers could behave "wrongly" (quoted as the driver is
> actually innocent...)

Currently, it's PITA on Linux to get a non-cached mmap properly in a
generic way.  Especially together with coherent memory allocations,
there is no API for that.  But, in the case of usb-audio, the problem
is the vmaloc'ed intermediate buffer, and this could be a bit easier.

One thing we can try is a patch like below.  But, I'm not sure whether
this is correct over all architectures, too.  At best, a generic API
would be helpful for such a thing...

thanks,

Takashi

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 9cf81bc..cecf4b4 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3136,6 +3136,7 @@ static int snd_pcm_default_mmap(struct snd_pcm_substream *substream,
 				struct vm_area_struct *area)
 {
 	area->vm_ops = &snd_pcm_vm_ops_data;
+	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
 	area->vm_private_data = substream;
 	area->vm_flags |= VM_RESERVED;
 	atomic_inc(&substream->mmap_count);
