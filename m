From: Pawel MOLL <pawel.moll@st.com>
Date: Thu, 25 Sep 2008 14:55:53 +0000
Subject: Re: [alsa-devel] Audio buffer mmap-ing on sh arch vs. cache
Message-Id: <1222354553.28498.30.camel@bri1004.bri.st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1220527434.3299.2074.camel@bri1004.bri.st.com>
	<s5h63owgdk1.wl%tiwai@suse.de>
In-Reply-To: <s5h63owgdk1.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org

Hi, Taksashi,

> One thing we can try is a patch like below.  But, I'm not sure whether
> this is correct over all architectures, too.  At best, a generic API
> would be helpful for such a thing...
> +	area->vm_page_prot =3D pgprot_noncached(area->vm_page_prot);

Well, it's not enough, because the kernel mapping of buffer is still
cached... A hack below does the job, but it is not nice as well...

Cheers

Pawe=C5=82

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 59b29cd..304f9e5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3159,6 +3159,9 @@ static struct vm_operations_struct snd_pcm_vm_ops_dat=
a  static int snd_pcm_default_mmap(struct snd_pcm_substream *substream,
                                struct vm_area_struct *area)
 {
+#ifdef pgprot_noncached
+       area->vm_page_prot =3D pgprot_noncached(area->vm_page_prot);
+#endif
        area->vm_ops =3D &snd_pcm_vm_ops_data;
        area->vm_private_data =3D substream;
        area->vm_flags |=3D VM_RESERVED;
diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index 7bd5852..c98a4ec 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -714,7 +714,8 @@ static int snd_pcm_alloc_vmalloc_buffer(struct snd_pcm_=
substream *subs, size_t s
                        return 0; /* already large enough */
                vfree(runtime->dma_area);
        }
-       runtime->dma_area =3D vmalloc(size);
+       runtime->dma_area =3D __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM,
+                       PAGE_KERNEL_NOCACHE);
        if (! runtime->dma_area)
                return -ENOMEM;
        runtime->dma_bytes =3D size;

