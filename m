From: takasi-y@ops.dti.ne.jp
Date: Tue, 10 Feb 2009 17:38:18 +0000
Subject: Re: [Qemu-devel] Status of SH4 support in repository
Message-Id: <200902101738.n1AHcIJn012970@smtp09.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20090209172352.cae23097.kristoffer.ericson@gmail.com>
In-Reply-To: <20090209172352.cae23097.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: qemu-devel@nongnu.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi,
> Just interested in an update of the current status. I built a fresh qemu from
> the repository today and Im currently I get no output. 
Which one have you tried?
svn://svn.sv.gnu.org/qemu/trunk@6587 works fine here.
Try
 ./configure --target-list=sh4-softmmu --disable-kqemu
 make
 sh4-softmmu/qemu-system-sh4 -M r2d --kernel kernel.kawa \
  --serial null --serial stdio 101M.img

Kernel is the one Kawasaki-san pointed in 
 http://lists.gnu.org/archive/html/qemu-devel/2009-01/msg01795.html

Cheers,
/yoshii
