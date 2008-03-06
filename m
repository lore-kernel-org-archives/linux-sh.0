From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Mar 2008 02:22:56 +0000
Subject: Re: [2.6 patch] sh_ksyms_32.c update for gcc 4.3
Message-Id: <20080306022256.GC31163@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080304223958.GA2136@cs181133002.pp.htv.fi>
In-Reply-To: <20080304223958.GA2136@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <adrian.bunk@movial.fi>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 05, 2008 at 12:39:58AM +0200, Adrian Bunk wrote:
> This patch fixes the following build error with landisk_defconfig when 
> using gcc 4.3:
> 
> <--  snip  -->
> 
> ...
>   MODPOST 50 modules
> ERROR: "__udivsi3_i4i" [net/sunrpc/sunrpc.ko] undefined!
> ERROR: "__udivsi3_i4i" [net/appletalk/appletalk.ko] undefined!
> ERROR: "__udivsi3_i4i" [fs/ufs/ufs.ko] undefined!
> ERROR: "__udivsi3_i4i" [fs/ntfs/ntfs.ko] undefined!
> ERROR: "__sdivsi3_i4i" [fs/ntfs/ntfs.ko] undefined!
> ERROR: "__udivsi3_i4i" [fs/nfsd/nfsd.ko] undefined!
> ERROR: "__sdivsi3_i4i" [fs/nfsd/nfsd.ko] undefined!
> ERROR: "__udivsi3_i4i" [fs/nfs/nfs.ko] undefined!
> ERROR: "__udivsi3_i4i" [fs/lockd/lockd.ko] undefined!
> ERROR: "__udivsi3_i4i" [drivers/usb/storage/usb-storage.ko] undefined!
> ERROR: "__sdivsi3_i4i" [drivers/usb/serial/pl2303.ko] undefined!
> ERROR: "__udivsi3_i4i" [drivers/usb/serial/pl2303.ko] undefined!
> ERROR: "__sdivsi3_i4i" [drivers/usb/serial/ftdi_sio.ko] undefined!
> ERROR: "__udivsi3_i4i" [drivers/usb/misc/sisusbvga/sisusbvga.ko] undefined!
> ERROR: "__sdivsi3_i4i" [drivers/usb/misc/sisusbvga/sisusbvga.ko] undefined!
> ERROR: "__udivsi3_i4i" [drivers/media/video/v4l1-compat.ko] undefined!
> ERROR: "__sdivsi3_i4i" [drivers/media/video/v4l1-compat.ko] undefined!
> ERROR: "__sdivsi3_i4i" [drivers/media/video/usbvideo/vicam.ko] undefined!
> ERROR: "__udivsi3_i4i" [drivers/media/video/usbvideo/usbvideo.ko] undefined!
> ERROR: "__sdivsi3_i4i" [drivers/media/video/usbvideo/usbvideo.ko] undefined!
> ERROR: "__udivsi3_i4i" [drivers/media/video/sn9c102/sn9c102.ko] undefined!
> ERROR: "__sdivsi3_i4i" [drivers/media/video/sn9c102/sn9c102.ko] undefined!
> ERROR: "__sdivsi3_i4i" [drivers/media/video/se401.ko] undefined!
> ERROR: "__sdivsi3_i4i" [drivers/media/video/pwc/pwc.ko] undefined!
> ERROR: "__udivsi3_i4i" [drivers/md/raid0.ko] undefined!
> ERROR: "__udivsi3_i4i" [drivers/md/md-mod.ko] undefined!
> ERROR: "__sdivsi3_i4i" [drivers/md/md-mod.ko] undefined!
> ERROR: "__udivsi3_i4i" [drivers/md/linear.ko] undefined!
> ERROR: "__sdivsi3_i4i" [drivers/hid/usbhid/usbhid.ko] undefined!
> make[2]: *** [__modpost] Error 1
> 
> <--  snip  -->
> 
> Signed-off-by: Adrian Bunk <adrian.bunk@movial.fi>
> 
Applied, thanks.
