From: Kaz Kojima <kkojima@rr.iij4u.or.jp>
Date: Fri, 16 Jan 2009 23:40:15 +0000
Subject: ERESTART* seen by userland
Message-Id: <20090117.084015.142054869.kkojima@rr.iij4u.or.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

It seems that some syscalls return with ERESTART* errno when
they should return EINTR in the recent SH kernels.
Has anybody experienced this?

Regards,
	kaz
