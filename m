From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 16 Mar 2010 12:28:08 +0000
Subject: Re: Trouble with embedding initial root fs into the kernel
Message-Id: <201003161328.09047.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

What default command kernel line I have to set?
the standard I find from MCP data is
console=ttySC0,19200 rootfstype=jffs2

but I have probelm with nor flash and so I'm tring to boot in a different way to 
have with busybox more test tools in my hands

Thanks a lot


In data martedì 16 marzo 2010 13:11:24, Fabio Giovagnini ha scritto:
: > Thanks a lot Magnus, I'll keep you informed abotu my progress
> 
> Cheers
> 
> In data martedì 16 marzo 2010 13:04:54, Magnus Damm ha scritto:
> : > On Tue, Mar 16, 2010 at 8:32 PM, Magnus Damm <magnus.damm@gmail.com>
> 
> wrote:
> > > On Tue, Mar 16, 2010 at 8:22 PM, Fabio Giovagnini
> > >
> > > <fabio.giovagnini@aurion-tech.com> wrote:
> > >> Hi All,
> > >> I'd like to know a link where to find info about step by spet
> > >> procedure to embedding the initial root fs into the kernel
> > >
> > > Which processor? I can email you a binary initramfs for sh4a if you
> > > are interested.
> >
> > Ok, as for a step-by-step of what I do, see below:
> >
> > 1. Start off with a small initramfs that contains /dev/console
> > already. I got the attached file from the kernel quite some time ago.
> >
> > 2. Put your files for the initramfs in the directory "tmp", then run
> > the following:
> > $ cp initramfs_data-base.cpio initramfs_data.cpio
> > $ cd tmp && ( find . | cpio -o -H newc --force-local -A -F
> > "../initramfs_data.cpio" )
> >
> > 3. Modify your kernel configuration to point our your initramfs_data.cpio
> >  file: CONFIG_INITRAMFS_SOURCE="/path/to/your/stuff/initramfs_data.cpio"
> >
> > 4. Make sure you include a script that creates device nodes for you,
> > or use udev or mdev.
> >
> > 5. I think /init is the first file that gets executed. I usually point
> > it to /sbin/init from busybox.
> >
> > 6. Start by using statically linked binaries to make it easy.
> >
> > 7. You can always try getting initramfs working with the sh4a binary
> > on the r2d board in QEMU.
> >
> > Hope this helps. It's also possible to point out the directory instead
> > of using an cpio file.
> >
> > / magnus
> 

-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
