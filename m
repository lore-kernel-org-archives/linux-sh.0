From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Mar 2010 12:04:54 +0000
Subject: Re: Trouble with embedding initial root fs into the kernel
Message-Id: <aec7e5c31003160504y1827f417y5962549fc3a569a5@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e65ae5d6474ea40481e9ceaa"
List-Id: <linux-sh.vger.kernel.org>
References: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
To: linux-sh@vger.kernel.org

--0016e65ae5d6474ea40481e9ceaa
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Mar 16, 2010 at 8:32 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Tue, Mar 16, 2010 at 8:22 PM, Fabio Giovagnini
> <fabio.giovagnini@aurion-tech.com> wrote:
>> Hi All,
>> I'd like to know a link where to find info about step by spet procedure to
>> embedding the initial root fs into the kernel
>
> Which processor? I can email you a binary initramfs for sh4a if you
> are interested.

Ok, as for a step-by-step of what I do, see below:

1. Start off with a small initramfs that contains /dev/console
already. I got the attached file from the kernel quite some time ago.

2. Put your files for the initramfs in the directory "tmp", then run
the following:
$ cp initramfs_data-base.cpio initramfs_data.cpio
$ cd tmp && ( find . | cpio -o -H newc --force-local -A -F
"../initramfs_data.cpio" )

3. Modify your kernel configuration to point our your initramfs_data.cpio file:
CONFIG_INITRAMFS_SOURCE="/path/to/your/stuff/initramfs_data.cpio"

4. Make sure you include a script that creates device nodes for you,
or use udev or mdev.

5. I think /init is the first file that gets executed. I usually point
it to /sbin/init from busybox.

6. Start by using statically linked binaries to make it easy.

7. You can always try getting initramfs working with the sh4a binary
on the r2d board in QEMU.

Hope this helps. It's also possible to point out the directory instead
of using an cpio file.

/ magnus

--0016e65ae5d6474ea40481e9ceaa
Content-Type: application/x-cpio; name="initramfs_data-base.cpio"
Content-Disposition: attachment; filename="initramfs_data-base.cpio"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6unkgep0

MDcwNzAxMDAwMDAyRDEwMDAwNDFFRDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMjQ2NTAwOTAwMDAw
MDAwMDAwMDAwMDAwMzAwMDAwMDAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA1MDAwMDAwMDAvZGV2
AAAwNzA3MDEwMDAwMDJEMjAwMDAyMTgwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxNDY1MDA5MDAw
MDAwMDAwMDAwMDAwMDAzMDAwMDAwMDEwMDAwMDAwNTAwMDAwMDAxMDAwMDAwMEQwMDAwMDAwMC9k
ZXYvY29uc29sZQAAMDcwNzAxMDAwMDAyRDMwMDAwNDFDMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MjQ2NTAwOTAwMDAwMDAwMDAwMDAwMDAwMzAwMDAwMDAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA2
MDAwMDAwMDAvcm9vdAAwNzA3MDEwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MEIwMDAwMDAwMFRSQUlMRVIhISEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
--0016e65ae5d6474ea40481e9ceaa--
