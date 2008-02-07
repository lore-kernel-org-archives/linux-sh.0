From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Thu, 07 Feb 2008 19:30:39 +0000
Subject: First real problem using g++ 3.4.6 uClibc-0.9.27-sh2
Message-Id: <200802072030.39924.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all, I report the behaviour of c++1stapp I compiled form the following 
source code:
#include <iostream>
using namespace std;
int main(int argc, char* argv[])
{
	cout << "Hello World!" << endl;
	cout << "Welcome to C++ Programming" << endl;
	return 0;
}


The output of the toolchain is:
fgiovagnini@aurio02:~/sh7203-uClinux-1.4/build> make -f Makefile.c++1stApp
make -e -C /home/fgiovagnini/sh7203-uClinux-1.4/build/../c++1stApp
make[1]: Entering directory `/home/fgiovagnini/sh7203-uClinux-1.4/c++1stApp'
sh-linux-g++ -m3e -mb -DGNU_SOURCE -Wall   -c -o main.o main.cpp
sh-linux-g++ -m3e -mb -Wl,-EB -Wl,-elf2flt=-s65536  -o c++1stApp main.o
Build DONE.
make[1]: Leaving directory `/home/fgiovagnini/sh7203-uClinux-1.4/c++1stApp'
mkdir 
-p /home/fgiovagnini/sh7203-uClinux-1.4/build/sh7203-images/root_fs/usr/local
cp 
-pv /home/fgiovagnini/sh7203-uClinux-1.4/build/../c++1stApp/c++1stApp /home/fgiovagnini/sh7203-uClinux-1.4/build/sh7203-images/root_fs/usr/local
`/home/fgiovagnini/sh7203-uClinux-1.4/build/../c++1stApp/c++1stApp' -> 
`/home/fgiovagnini/sh7203-uClinux-1.4/build/sh7203-images/root_fs/usr/local/c++1stApp'

and it seems correct.

I copy onto the target and I read.
root:/home> ./c\+\+1stApp
Fixing up unaligned userspace access in "c++1stApp" pidI pc=0x0c82ee00 
ins=0x30d0
Killing process "c++1stApp" due to unaligned access
SIGSEGV
root:/home>

Other guys on otner archs had the same problem if I guess, but I do not know 
the solution.

Regards




-- 
Fabio Giovagnini

Aurion s.r.l.
via degli orti 11,
40050 Funo di Argelato (BO)
P.I e C.F.
00885711200
Tel. +39.335.8350919
Fax +39.051.8659009

www.aurion-tech.com

account telefono VoIP skype (www.skype.com):
aurion.giovagnini
