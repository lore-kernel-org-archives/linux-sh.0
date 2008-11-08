From: takasi-y@ops.dti.ne.jp
Date: Sat, 08 Nov 2008 15:28:35 +0000
Subject: Re: Concerning Qemu SH4
Message-Id: <200811081528.mA8FSZaC010580@smtp12.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20081108020202.0c9a4b59.kristoffer.ericson@gmail.com>
In-Reply-To: <20081108020202.0c9a4b59.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

> Oki, gotten it to work now. Whats left is putting some sort 
> of harddrive file there. I've created an loop file but
> can't seem to get it going.
Have you applied all patches on ML?
Otherwise it doesn't support hard disk.
QEMU repository is being maintained very slowly.
There always many patches left on ML waiting for being merged.

Now, following patches are pending.
http://lists.gnu.org/archive/html/qemu-devel/2008-10/msg00970.html
 This must be applied. Otherwise it will be crashed frequently.
http://lists.gnu.org/archive/html/qemu-devel/2008-10/msg01246.html
http://lists.gnu.org/archive/html/qemu-devel/2008-10/msg01247.html
http://lists.gnu.org/archive/html/qemu-devel/2008-10/msg01248.html
 These three are needed use to use HDD.
http://lists.gnu.org/archive/html/qemu-devel/2008-11/msg00118.html
http://lists.gnu.org/archive/html/qemu-devel/2008-11/msg00119.html
 These two are needed to use network.

Some of them can't be applied cleanly, because other patch has been
 applied after I posted them. Please edit them manually.

> I'm also missing something with the initrd as it
> constantly claims that the initrd expands beyond
> the memory boundry.
Current code doesn't support --initrd nor --append.
Only --kernel works. Use initramfs and initial command line.

/yoshii
