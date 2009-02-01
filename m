From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Sun, 01 Feb 2009 07:57:15 +0000
Subject: qemu-sh repository does not apply
Message-Id: <498555DB.8090702@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Paul.

Current qemu svn head and qemu-sh staging repository do not fit together,
because of the progress of qemu development.  'quilt push -a' command
stops with patch failure.  I think this defect should be fixed for
qemu-sh users.

I'm sending two patches against qemu-sh staging repository after this mail.
With these patches, qemu rev.6489 and qemu-sh repository work together finely.
Could you check and apply them?

If this patch sending action is not appropriate, please let me know.


Regards,
Shin-ichiro KAWASAKI
