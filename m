From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 22 Mar 2011 07:53:19 +0000
Subject: sh2a 7203 LCDC memory access
Message-Id: <201103220853.19384.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi All,
I'd likt to keep you informed about my last discovering about LCDC of sh2a 
7203.
If I build the kernel with cache off, the image is clean and stable but the 
performances are very very poor;
if I build with cache write back the performaces are very good but the image 
is stable but sometimes dirty; fi I build with cache write through the 
performances seems to be a little bit less than write back but the image is 
stiil clean and stable.
Does this make sense?
How can I explain this behaviour?

Thanks in advance

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
