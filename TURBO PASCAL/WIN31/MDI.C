

 /* filename :	mdi.c							*/
 /* source   :	PC Report nr.22 / july 1994		*/


 #include <windows.h>
 #include <stdlib.h>
 #include "mdi.h"


 /* function prototypes ...	*/
 long FAR PASCAL FrameWndProc( 	   HWND, UINT, WPARAM, LPARAM ); 
 long FAR PASCAL TextChildWndProc( HWND, UINT, WPARAM, LPARAM );
 long FAR PASCAL GrafChildWndProc( HWND, UINT, WPARAM, LPARAM );
 BOOL FAR PASCAL CloseEnumProc(    HWND, LPARAM );


 typedef struct
 {
	short	 nColor;
	COLORREF cText;
 } TEXTDATA;
 typedef TEXTDATA NEAR * NPTEXTDATA;


 typedef struct
 {
	short 	cxRect;
	short	cyRect;
 } RECTDATA;
 typedef RECTDATA NEAR * NPRECTDATA;


 char	szMainClass[] = "mdi";
 char	szTextClass[] = "mdiTEXT";
 char	szGrafClass[] = "mdiGRAF";

 HANDLE	hInst;
 HMENU	hMenuInit, hMenuText, hMenuGraf;
 HMENU	hMenuInitWnd, hMenuTextWnd, hMenuGrafWnd;


 /* defining functions ... 	*/
 int	PASCAL WinMain( HANDLE hInstance,   HANDLE hPrevInstance,
						LPSTR  lpszCmdLine, int   nCmdShow	 )
 {
	HANDLE		hAcc;
	HWND		hWndMain, hWndClient;
	MSG			msg;
	WNDCLASS    wndclass;

	hInst = hInstance;
	if( !hPrevInstance )
	{
        wndclass.lpszClassName	= szFrameClass;
		wndclass.style		= CS_HREDRAW | CS_VREDRAW;
		wndclass.lpfnWndProc= (WNDPROC)FrameWndProc;
		wndclass.cbClsExtra	= 0;
		wndclass.cbWndExtra	= sizeof(LOCALHANDLE);
		wndclass.hInstance	= hInst;
		wndclass.hIcon 		= LoadIcon( NULL, IDI_APPLICATION );
		wndclass.hCursor	= LoadCursor( NULL, IDC_CROSS );
		wndclass.hbrBackground	= GetStockObject( WHITE_BRUSH );
		wndclass.lpszMenuName	= NULL;
		if( !RegisterClass( &wndclass ) )
			return FALSE;

                wndclass.lpszClassName	= szGrafClass;
		wndclass.style		= CS_HREDRAW | CS_VREDRAW;
		wndclass.lpfnWndProc	= (WNDPROC)GrafChildWndProc;
		wndclass.cbClsExtra	= 0;
		wndclass.cbWndExtra	= sizeof(LOCALHANDLE);
		wndclass.hInstance	= hInst;
		wndclass.hIcon 		= LoadIcon( NULL, IDI_APPLICATION );
		wndclass.hCursor	= LoadCursor( NULL, IDC_CROSS );
		wndclass.hbrBackground	= GetStockObject( WHITE_BRUSH );
		wndclass.lpszMenuName	= NULL;
		if( !RegisterClass( &wndclass ) )
			return FALSE;


		wndclass.lpszClassName	= szTextClass;
		wndclass.style		= CS_HREDRAW | CS_VREDRAW;
		wndclass.lpfnWndProc	= (WNDPROC)TextChildWndProc;
		wndclass.cbClsExtra	= 0;
		wndclass.cbWndExtra	= sizeof(LOCALHANDLE);
		wndclass.hInstance	= hInst;
		wndclass.hIcon 		= LoadIcon( NULL, IDI_APPLICATION );
		wndclass.hCursor	= LoadCursor( NULL, IDC_CROSS );
		wndclass.hbrBackground	= GetStockObject( WHITE_BRUSH );
		wndclass.lpszMenuName	= NULL;
		if( !RegisterClass( &wndclass ) )
			return FALSE;

	}


    /* Load resorces ... */
    hMenuInit		=	LoadMenu( hInst, "MenuInit" );
	hMenuText		=	LoadMenu( hInst, "MenuText" );
	hMenuGraf		=	LoadMenu( hInst, "MenuGraf" );

	hMenuInitWnd	= 	GetSubMenu( hMenuInit, INIT_MENU_POS );
	hMenuTextWnd	= 	GetSubMenu( hMenuText, TEXT_MENU_POS );
	hMenuGrafWnd	= 	GetSubMenu( hMenuGraf, GRAF_MENU_POS );

	hAcc			= 	LoadAccelerators( hInst, "MdiAccel" );



    /*  Create main window ... */
	hWndMain	= 	CreateWindow( szFrameClass,
					      "Exemplificare MDI",
					      WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN,
					      CW_USEDEFAULT, CW_USEDEFAULT,
					      CW_USEDEFAULT, CW_USEDEFAULT,
					      NULL, hMenuInit, hInst, NULL );
	hWndClient	=	GetWindow( hWndMain, GW_CHILD );
	ShowWindow( hWndMain, nCmdShow );
	UpdateWindow( hWndMain );

	while( GetMessage( &msg, NULL, 0,0 ) )
	{
		if( !TranslateMDISysAccel(  hWndClient, &msg ) &&
		    !TranslateAccelerator( hWndMain, hAcc, &msg ) )
		    {
			TranslateMessage( &msg );
			DispatchMessage(  &msg );
		    }
	}
	return msg.wParam;
 }



 long	FAR PASCAL FrameWndProc( HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam )
 {
	CLIENTCREATESTRUCT	clistru;
	MDICREATESTRUCT		mdics;
	static HWND 		hWndClient;
	FARPROC			lpfnEnum;
	HWND			hWndChild;

	switch(message)
	{
		case WM_CREATE:
			clistru.hWindowMenu  = hMenuInitWnd;
			clistru.idFirstChild = ID_FIRSTCHILD;
			hWndClient = CreateWindow( "MDICLIENT", NULL,
				WS_CHILD | WS_CLIPCHILDREN | WS_VISIBLE,
				0, 0, 0, 0,
				hWnd, 1, hInst, (LPSTR)&clistru );
			break;

		case WM_COMMAND:
			switch(wParam)
			{
			  case IDM_TEXT:
				mdics.szClass	= szTextClass;
				mdics.szTitle	= "Text";
				mdics.hOwner	= hInst;
				mdics.x		= CW_USEDEFAULT;
				mdics.y		= CW_USEDEFAULT;
				mdics.cx	= CW_USEDEFAULT;
				mdics.cy	= CW_USEDEFAULT;
				mdics.style	= 0;
				mdics.lParam	= NULL;
				hWndChild = (HWND)SendMessage( hWndClient,
					WM_MDICREATE, 0,
					(LPARAM)(LPMDICREATESTRUCT)&mdics );
				break;


			  case IDM_GRAPHICS:
				mdics.szClass	= szGrafClass;
				mdics.szTitle	= "Grafica";
				mdics.hOwner	= hInst;
				mdics.x		= CW_USEDEFAULT;
				mdics.y		= CW_USEDEFAULT;
				mdics.cx	= CW_USEDEFAULT;
				mdics.cy	= CW_USEDEFAULT;
				mdics.style	= 0;
				mdics.lParam	= NULL;
				hWndChild = (HWND)SendMessage( hWndClient,
					WM_MDICREATE, 0,
					(LPARAM)(LPMDICREATESTRUCT)&mdics );
				break;


			  case IDM_CLOSE:
				hWndChild = (HWND)SendMessage( hWndClient,
					WM_MDIGETACTIVE, 0, 0L );
				if( SendMessage( hWndChild,
					WM_QUERYENDSESSION, 0, 0L ) )
				    SendMessage( hWndClient, WM_MDIDESTROY,
						 hWndChild, 0L );
				break;


			  case IDM_EXIT:
				SendMessage( hWnd, WM_CLOSE, 0, 0L );
				break;


			  case IDM_TILE:
				SendMessage( hWndClient, WM_MDITILE, 0, 0L );
                                break;


			  case IDM_CASCADE:
				SendMessage( hWndClient, WM_MDICASCADE, 0, 0L );
                                break;


			  case IDM_ARRANGEICON:
				SendMessage( hWndClient, WM_MDIICONARRANGE, 0, 0L );
                                break;


			  case IDM_CLOSEALL:
				lpfnEnum = MakeProcInstance( CloseEnumProc, hInst );
				EnumChildWindows( hWndClient, lpfnEnum, 0L );
				FreeProcInstance( lpfnEnum );
				break;

			  default:
				hWndChild = LOWORD( SendMessage( hWndClient,
					    WM_MDIGETACTIVE, 0, 0L ) );
				if( IsWindow( hWndChild ) )
					SendMessage( hWndChild, WM_COMMAND,
						     wParam, lParam );
				return DefFrameProc( hWnd, hWndClient,
					    message, wParam, lParam );
			} /* end of WM_COMMAND switch */
			break;

		case WM_DESTROY:
			PostQuitMessage(0);
			break;


		case WM_CLOSE:
		case WM_QUERYENDSESSION:
			SendMessage( hWnd, WM_COMMAND, IDM_CLOSEALL, 0L );
			if( NULL != GetWindow( hWndClient, GW_CHILD ) )
				break;

		default:
			return DefFrameProc( hWnd, hWndClient, message,
					     wParam, lParam );
	}
	return 0;
 }



 BOOL FAR PASCAL CloseEnumProc( HWND hWnd, LPARAM lParam )
 {
	if( GetWindow(hWnd, GW_OWNER) )
		return TRUE;
	SendMessage( GetParent(hWnd), WM_MDIRESTORE, hWnd, 0L );
	if( !SendMessage( hWnd, WM_QUERYENDSESSION, 0, 0L ) )
		return TRUE;
	SendMessage( GetParent(hWnd), WM_MDIDESTROY, hWnd, 0L );
		return TRUE;
 }




 long FAR PASCAL TextChildWndProc( HWND 	hWnd, 	UINT message,
				   WPARAM 	wParam, LPARAM lParam	 )
 {
	static COLORREF ca[] = { RGB(000,000,000), RGB(255,000,000),
				 RGB(000,255,000), RGB(000,000,255),
				 RGB(255,255,255)  };
	static HWND 	hWndClient, hWndMain;
	NPTEXTDATA      nptd;
	LOCALHANDLE   	htd;
	PAINTSTRUCT	ps;
	HMENU		hm;
	RECT		r;
	HDC		hDC;

	switch( message )
	{
		case WM_CREATE:
			htd = LocalAlloc( LHND, sizeof(TEXTDATA) );
			nptd = (NPTEXTDATA)LocalLock( htd );
			nptd->nColor = IDM_BLACK;
			nptd->cText = ca[0];
			LocalUnlock( htd );
			SetWindowWord( hWnd, 0, htd );
			hWndClient = GetParent( hWnd );
			hWndMain = GetParent( hWndClient );
			break;

		case WM_COMMAND:
			switch( wParam )
			{
				case IDM_BLACK:
				case IDM_RED:
				case IDM_GREEN:
				case IDM_BLUE:
				case IDM_WHITE:
				       htd = GetWindowWord( hWnd, 0 );
					   nptd = (NPTEXTDATA)LocalLock( htd );
				       hm = GetMenu( hWndMain );
				       CheckMenuItem( hm, nptd->nColor,MF_CHECKED );
				       nptd->cText = ca[wParam-IDM_BLACK];
				       LocalUnlock( htd );
				       InvalidateRect( hWnd, NULL, FALSE );
				       break;
			}
			break;

		case WM_PAINT:
			hDC = BeginPaint( hWnd, &ps );
			htd = GetWindowWord( hWnd, 0 );
			nptd = (NPTEXTDATA)LocalLock( htd );
			SetTextColor( hDC, nptd->cText );
			LocalUnlock( htd );
			GetClientRect( hWnd, &r );
			DrawText( hDC, "Un text ... ca aceasta", -1, &r,
				  DT_SINGLELINE | DT_CENTER | DT_VCENTER );
			EndPaint( hWnd, &ps );
			break;

		case WM_MDIACTIVATE:
			if( wParam==TRUE )
				SendMessage( hWndClient, WM_MDISETMENU, 0,
				   MAKELONG(hMenuText, hMenuTextWnd) );
				htd = GetWindowWord( hWnd, 0 );
				nptd = (NPTEXTDATA)LocalLock( htd );
				CheckMenuItem( hm, nptd->nColor, wParam ? MF_CHECKED : MF_UNCHECKED );
				LocalUnlock( htd );
			if( wParam == FALSE )
				SendMessage( hWndClient, WM_MDISETMENU, 0,
				   MAKELONG(hMenuInit,hMenuInitWnd) );
				DrawMenuBar( hWndMain );
			break;

		case WM_DESTROY:
			htd = GetWindowWord( hWnd, 0 );
			LocalFree( htd );
			break;

		case WM_QUERYENDSESSION:
		case WM_CLOSE:
			if( IDOK != MessageBox( hWnd, "Confirma inchiderea ferestrei!","Confirmare",
				       MB_ICONQUESTION | MB_OKCANCEL ) )
			break;

		default:
			return DefMDIChildProc( hWnd, message, wParam, lParam );
	}
	return 0;
 }




 long FAR PASCAL GrafChildWndProc( HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam )
 {
	static HWND hWndClient, hWndMain;
	NPRECTDATA nprd;
	LOCALHANDLE hrd;
	PAINTSTRUCT ps;
	HDC	hDC;
	HBRUSH hBrush;
	short xl, xr, yt, yb;
	short nR, nG, nB;

	switch(message)
	{
		case WM_CREATE:
			hrd = LocalAlloc( LHND, sizeof(RECTDATA) );
			SetWindowWord( hWnd, 0, hrd );
		 	SetTimer( hWnd, 1, 250, NULL );
			hWndClient = GetParent( hWnd );
			hWndMain = GetParent( hWndClient );
			break;

		 case WM_SIZE:
			 hrd = GetWindowWord( hWnd, 0 );
			 nprd = (NPRECTDATA)LocalLock( hrd );
			 nprd->cxRect = LOWORD( lParam );
			 nprd->cyRect = HIWORD( lParam );
                         LocalUnlock( hrd );
			 return DefMDIChildProc( hWnd, message, wParam, lParam );

		 case WM_TIMER:
			 hrd = GetWindowWord( hWnd, 0 );
			 nprd = (NPRECTDATA)LocalLock( hrd );
			 xl = rand() % nprd->cxRect;
			 xr = rand() % nprd->cxRect;
			 yt = rand() % nprd->cyRect;
			 yb = rand() % nprd->cyRect;
			 nR = rand() % 255;
			 nG = rand() % 255;
			 nB = rand() % 255;
			 hDC = GetDC( hWnd );
			 hBrush = CreateSolidBrush( RGB(nR,nG,nB) );
			 SelectObject( hDC, hBrush );
			 Rectangle( hDC, min(xl,xr), min(yt,yb),
					 max(xl,xr), max(yt,yb)	);
			 ReleaseDC( hWnd, hDC );
			 DeleteObject( hBrush );
			 LocalUnlock( hrd );
			 break;

		 case WM_PAINT:
			 InvalidateRect( hWnd, NULL, TRUE );
			 hDC = BeginPaint( hWnd, &ps );
			 EndPaint( hWnd, &ps );
			 break;

		 case WM_MDIACTIVATE:
			 if( wParam == TRUE )
				SendMessage( hWndClient, WM_MDISETMENU, 0,
					     MAKELONG(hMenuGraf,hMenuGrafWnd) );
			 else   SendMessage( hWndClient, WM_MDISETMENU, 0,
					     MAKELONG(hMenuInit,hMenuInitWnd) );
			 DrawMenuBar( hWndMain );
			 break;

		 case WM_DESTROY:
			 hrd = GetWindowWord( hWnd, 0 );
			 LocalFree( hrd );
			 KillTimer( hWnd, 1 );
                         break;

		 case WM_QUERYENDSESSION:
		 case WM_CLOSE:
			 if( IDOK != MessageBox( hWnd, "Confirma inchiderea ferestrei!",
						 "Confirmare", MB_ICONQUESTION | MB_OKCANCEL ) );
			 break;

		 default:
			 return DefMDIChildProc( hWnd, message, wParam, lParam );
			   
	}
	return 0;
 }
