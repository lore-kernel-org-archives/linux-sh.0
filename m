From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 16 Sep 2008 14:12:37 +0000
Subject: Re: initramfs problems
Message-Id: <20080916141236.GA18310@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <600adaf50809160627p8ed94c5y5e4502042c617808@mail.gmail.com>
In-Reply-To: <600adaf50809160627p8ed94c5y5e4502042c617808@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 16, 2008 at 10:27:29AM -0300, Tiago Maluta wrote:
> Hi,
> 
> I'm with problems to attach an iniramfs to vmlinux. I'm using:
> linux-2.6.17.14_stm22_0038
> 
> From Documentation/filesystem/ramfs-romfs-initramfs.txt I got that I
> can start initramfs by three ways
> 
> a) gzipped cpio archive
> b) directory containing a filesystem
> c) textfile
> 
> My first approach was using option b)
> 
> I read Documentation/early-userspace/README and populated a simple fs.
> Basically, for my first test, I used the filesystem that already use
> on MTD block.
> 
You might also want to take a look at:

http://www.linux-sh.org/shwiki/Using_Early_User_Space
