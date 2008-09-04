From: Pawel MOLL <pawel.moll@st.com>
Date: Thu, 04 Sep 2008 11:23:54 +0000
Subject: Audio buffer mmap-ing on sh arch vs. cache aliasing problem
Message-Id: <1220527434.3299.2074.camel@bri1004.bri.st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org

Hi Guys,

Recently I was investigating an issue with capturing audio using USB
Audio Class device on a sh4-based board. "Bad voice quality" was
reported...

Finally I have traced the problem to something which is (unfortunately)
well known to sh developers as a D-cache aliasing (or synonym) problem.=20

Briefly speaking: due to some MMU design decisions, one can have two
different virtual address pointing to the same physical location, which
is fine, but going via different cache slots! So if there was a value of
"0" in the memory and user "A" will write "1" there, user "B" will still
read "0"...

The solution is to ensure all TLB entries (so virtual memory areas) are
beginning from a 16kB-aligned virtual address. Otherwise it is necessary
to flush the cache between accesses from "A" and "B" sides.

And now. The USB Audio Class driver (sound/usb/usbaudio.c) is allocating
the sound buffer like this...

static int snd_pcm_alloc_vmalloc_buffer(struct snd_pcm_substream *subs, siz=
e_t size)
{
[...]
	runtime->dma_area =3D vmalloc(size);
[...]
}

... and vmalloc will return a page(4k)-aligned pointer, possibly not
16k-aligned one. This is the source of all evil ;-)=20

When using RW transfers everything is fine, as data is memcopied between
two independent buffers.

In a case of MMAP mode we will end up with such a situation:

1. The driver will memcpy data from an URB to the buffer. It will
populate several cache lines. Let's call it a "kernel cache".
2. As the library has mapped the non-16k-aligned address via different
cache line ("user cache"), it will read some rubbish from the physical
memory, populating the "user cache" by the way.
3. Some time later the "kernel cache" is flushed, writing the data to
the memory.
4. Some new data from URB is entering "kernel cache".
5. The library will access mmap-ed area again, going via the "user
cache", which may or may not reflect the correct data (depending on the
fact was the "user cache" flushed or not) etc.

Of course this cycle is completely not deterministic, so some of the
"kernel cache" lines will be flushed before being accessed from user
space, other not... The final effect is... hmm... bizarre :-) First, of
course, you will get a (probably loud) glitch (rubbish from buffer's
underlying memory, before the first valid data is written back), and
then something that could be described as an "echo" ;-) I mean - you are
capturing "1 2 3 4 5 6 7..." and the result is (G stands for Glitch ;-)
"G 1 23 3 4 4 6 67..."

As a quick-and-dirty work-around I have modified
snd_pcm_alloc_vmalloc_buffer() to allocate always 12kB more and then use
16k-aligned pointer:

static int snd_pcm_alloc_vmalloc_buffer(struct snd_pcm_substream *subs, siz=
e_t size)
{
        struct snd_pcm_runtime *runtime =3D subs->runtime;
        if (runtime->dma_addr) {
                if (runtime->dma_bytes >=3D size)
                        return 0; /* already large enough */
                vfree((void *)runtime->dma_addr);
        }
        runtime->dma_addr =3D (unsigned long)vmalloc(size + 12 * 1024);
        if (!runtime->dma_addr)
                return -ENOMEM;
        runtime->dma_area =3D (void *)ALIGN(runtime->dma_addr, 16 * 1024);
        runtime->dma_bytes =3D size;
        return 0;
}

Of course it cannot be regarded as anything more as a hack. And
definitely not as a solution... So my question is:

Any idea how the "proper solution" should look like? I see no obvious
method to get an arch-independent "mmap-compliant" buffer. This problem
was found on a sh arch, using an USB Audio Class device, however out
there some other architectures are suffering from this MMU "feature" as
well (ie. see http://docs.hp.com/en/B3906-90006/ch07s09.html) and
possibly other drivers could behave "wrongly" (quoted as the driver is
actually innocent...)

To be honest I just have absolutely no idea what to do with this
all! :-O

I hope I was clear enough in the description... Any feedback, advise,
idea etc. will be more than appreciated.

Cheers

Pawe=C5=82

