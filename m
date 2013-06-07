From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 07 Jun 2013 23:51:38 +0000
Subject: [PATCH 0/9] sh_eth: make driver build on any platform
Message-Id: <201306080351.39018.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

Hello.

   This series of 9 patches are against Dave's 'net-next.git' repository.
   The series deals with the #ifdef'fery around SoC support code/data in the
'sh_eth' driver. It doesn't yet get rid of all the #ifdef's: 3 are left, 1 of
them still hinders ARM multiplatform build -- I'll try to deal with it next
week.

[1/9] sh_eth: create initial ID table
[2/9] sh_eth: get SH771x support out of #ifdef
[3/9] sh_eth: get SH7619 support out of #ifdef
[4/9] sh_eth: get R8A7740 support out of #ifdef
[5/9] sh_eth: get SH77{34|63} support out of #ifdef
[6/9] sh_eth: get SH7757 support out of #ifdef
[7/9] sh_eth: get SH7724 support out of #ifdef
[8/9] sh_eth: get R8A777x support out of #ifdef
[9/9] sh_eth: remove dependencies from Kconfig

WBR, Sergei
